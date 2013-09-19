# encoding: BINARY

require 'spec_helper'

describe Krypt::Asn1::Der::HeaderParser do

  let(:hp) { Krypt::Asn1::Der::HeaderParser }
  let(:tag) { Krypt::Asn1::Der::Tag }
  let(:tag_class) { Krypt::Asn1::Der::TagClass }

  describe '#next' do

    context 'definite length' do

      context 'primitive' do

        context ':UNIVERSAL INTEGER 42' do
          let(:enc) { "\x02\x01\x2A" }

          context 'tag' do
            subject { hp.new(enc).next.asn1_object.tag }

            its(:tag) { should eq(tag::INTEGER) }
            its(:constructed?) { should be_false }
            its(:encoding) { should eq("\x02") }
          end

          context 'tag_class' do
            subject { hp.new(enc).next.asn1_object.tag.tag_class }

            its(:tag_class) { should eq(:UNIVERSAL) }
            its(:mask) { should eq(tag_class::UNIVERSAL) }
          end

          context 'length' do
            subject { hp.new(enc).next.asn1_object.length }

            its(:length) { should eq(1) }
            its(:indefinite?) { should be_false }
            its(:encoding) { should eq("\x01") }
          end

          context 'value' do
            subject { hp.new(enc).next.asn1_object.value }

            it { should eq("\x2A") }
          end
        end

        context ':UNIVERSAL OCTET STRING complex length 2 bytes' do
          let(:enc) { "\x04\x82\x01\x00" << ("\xFF" * 256) }

          context 'tag' do
            subject { hp.new(enc).next.asn1_object.tag }

            its(:tag) { should eq(tag::OCTET_STRING) }
            its(:constructed?) { should be_false }
            its(:encoding) { should eq("\x04") }
          end

          context 'tag_class' do
            subject { hp.new(enc).next.asn1_object.tag.tag_class }

            its(:tag_class) { should eq(:UNIVERSAL) }
            its(:mask) { should eq(tag_class::UNIVERSAL) }
          end

          context 'length' do
            subject { hp.new(enc).next.asn1_object.length }

            its(:length) { should eq(256) }
            its(:indefinite?) { should be_false }
            its(:encoding) { should eq("\x82\x01\x00") }
          end

          context 'value' do
            subject { hp.new(enc).next.asn1_object.value }

            it { should eq("\xFF" * 256) }
          end
        end

        context ':UNIVERSAL complex tag 150 two bytes' do
          let(:enc) { "\xDF\x81\x16\x01\x01" }

          context 'tag' do
            subject { hp.new(enc).next.asn1_object.tag }

            its(:tag) { should eq(150) }
            its(:constructed?) { should be_false }
            its(:encoding) { should eq("\xDF\x81\x16") }
          end

          context 'tag_class' do
            subject { hp.new(enc).next.asn1_object.tag.tag_class }

            its(:tag_class) { should eq(:PRIVATE) }
            its(:mask) { should eq(tag_class::PRIVATE) }
          end

          context 'length' do
            subject { hp.new(enc).next.asn1_object.length }

            its(:length) { should eq(1) }
            its(:indefinite?) { should be_false }
            its(:encoding) { should eq("\x01") }
          end

          context 'value' do
            subject { hp.new(enc).next.asn1_object.value }

            it { should eq("\x01") }
          end
        end

        context ':CONTEXT_SPECIFIC 0 IMPLICIT' do
          let(:enc) { "\x80\x01\x01" }

          context 'tag' do
            subject { hp.new(enc).next.asn1_object.tag }

            its(:tag) { should eq(0) }
            its(:constructed?) { should be_false }
            its(:encoding) { should eq("\x80") }
          end

          context 'tag_class' do
            subject { hp.new(enc).next.asn1_object.tag.tag_class }

            its(:tag_class) { should eq(:CONTEXT_SPECIFIC) }
            its(:mask) { should eq(tag_class::CONTEXT_SPECIFIC) }
          end
        end

        context ':CONTEXT_SPECIFIC 0 INTEGER 0 EXPLICIT' do
          let(:enc) { "\xA0\x03\x02\x01\x00" }

          context 'tag' do
            subject { hp.new(enc).next.asn1_object.tag }

            its(:tag) { should eq(0) }
            its(:constructed?) { should be_true }
            its(:encoding) { should eq("\xA0") }
          end

          context 'tag_class' do
            subject { hp.new(enc).next.asn1_object.tag.tag_class }

            its(:tag_class) { should eq(:CONTEXT_SPECIFIC) }
            its(:mask) { should eq(tag_class::CONTEXT_SPECIFIC) }
          end
        end

        context ':APPLICATION 0' do
          let(:enc) { "\x40\x01\x00" }

          context 'tag' do
            subject { hp.new(enc).next.asn1_object.tag }

            its(:tag) { should eq(0) }
            its(:constructed?) { should be_false }
            its(:encoding) { should eq("\x40") }
          end

          context 'tag_class' do
            subject { hp.new(enc).next.asn1_object.tag.tag_class }

            its(:tag_class) { should eq(:APPLICATION) }
            its(:mask) { should eq(tag_class::APPLICATION) }
          end
        end

        context ':PRIVATE 0' do
          let(:enc) { "\xC0\x01\x00" }

          context 'tag' do
            subject { hp.new(enc).next.asn1_object.tag }

            its(:tag) { should eq(0) }
            its(:constructed?) { should be_false }
            its(:encoding) { should eq("\xC0") }
          end

          context 'tag_class' do
            subject { hp.new(enc).next.asn1_object.tag.tag_class }

            its(:tag_class) { should eq(:PRIVATE) }
            its(:mask) { should eq(tag_class::PRIVATE) }
          end
        end
      end

    end

  end

  context 'indefinite length' do

    context 'constructed' do

      context ':UNIVERSAL OCTET STRING 01 02' do
        let(:enc) { "\x24\x80\x04\x01\x01\x04\x01\x02\x00\x00" }

        context 'tag' do
          subject { hp.new(enc).next.asn1_object.tag }

          its(:tag) { should eq(tag::OCTET_STRING) }
          its(:constructed?) { should be_true }
          its(:encoding) { should eq("\x24") }
        end

        context 'tag_class' do
          subject { hp.new(enc).next.asn1_object.tag.tag_class }

          its(:tag_class) { should eq(:UNIVERSAL) }
          its(:mask) { should eq(tag_class::UNIVERSAL) }
        end

        context 'length' do
          subject { hp.new(enc).next.asn1_object.length }

          its(:length) { should be_nil }
          its(:indefinite?) { should be_true }
          its(:encoding) { should eq("\x80") }
        end

        context 'value' do
          subject { hp.new(enc).next.asn1_object.value }

          it { should eq("\x04\x01\x01\x04\x01\x02\x00\x00") }
        end
      end

    end

  end

  context 'from IO' do

    context ':UNIVERSAL BOOLEAN true' do
      let(:enc) { StringIO.new("\x01\x01\xFF") }

      context 'tag' do
        subject { hp.new(enc).next.asn1_object.tag }

        its(:tag) { should eq(tag::BOOLEAN) }
        its(:constructed?) { should be_false }
        its(:encoding) { should eq("\x01") }
      end

      context 'tag_class' do
        subject { hp.new(enc).next.asn1_object.tag.tag_class }

        its(:tag_class) { should eq(:UNIVERSAL) }
        its(:mask) { should eq(tag_class::UNIVERSAL) }
      end

      context 'length' do
        subject { hp.new(enc).next.asn1_object.length }

        its(:length) { should eq(1) }
        its(:indefinite?) { should be_false }
        its(:encoding) { should eq("\x01") }
      end

      context 'value' do
        subject { hp.new(enc).next.asn1_object.value }

        it { should eq("\xFF") }
      end
    end

  end

  it 'raises for an invalid complex tag with bits 7 to 1 equal to zero' do
    expect { hp.new("\xDF\x80\x16\x01\x01").next }.to raise_error
  end

  it 'raises for an initial complex length octet 0xFF' do
    expect { hp.new("\x04\xFF").next }.to raise_error
  end

  it 'raises for an unknown tag class' do
    expect { tag_class.of_mask(42) }.to raise_error
  end

  context 'allows to read the header value in a streaming manner with a buffer' do
    subject { hp.new(der).next.value_io.read(nil, buf) }

    context 'definite length' do
      let(:der) { "\x01\x01\xFF" }
      let(:buf) { "" }

      it { should eq("\xFF") }
      it { should be(buf) }
    end

    context 'indefinite length' do
      let(:der) { "\x24\x80\x04\x01\x01\x00\x00" }
      let(:buf) { "" }

      it { should eq("\x04\x01\x01\x00\x00") }
      it { should be(buf) }
    end

    context 'byte by byte' do
      subject { hp.new(der).next.value_io.read(1) }

      context 'definite length' do
        let(:der) { "\x02\x02\xFF\x00" }

        it { should eq("\xFF") }
      end

      context 'indefinite length' do
        let(:der) { "\x24\x80\xDF\x81\x16\x01\x01\x00\x00" }

        it { should eq("\xDF") }
      end
    end
  end

end

