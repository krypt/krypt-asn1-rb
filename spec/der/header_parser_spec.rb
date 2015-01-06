# encoding: BINARY

require 'spec_helper'

RSpec.describe Krypt::Asn1::Der::HeaderParser do

  let(:hp) { Krypt::Asn1::Der::HeaderParser }
  let(:tag) { Krypt::Asn1::Der::Tag }
  let(:tag_class) { Krypt::Asn1::Der::TagClass }

  describe '#next' do

    context 'definite length' do

      context 'primitive' do

        context ':UNIVERSAL INTEGER 42' do
          let(:enc) { "\x02\x01\x2A" }

          context 'tag' do
            subject { hp.new(enc).next.create_der.tag }

            it "has an INTEGER tag" do
              expect(subject.tag).to eq(Krypt::Asn1::INTEGER)
            end
            it "is primitive" do
              expect(subject.constructed?).to eq(false)
            end
            it 'encodes to \x02' do
              expect(subject.encoding).to eq("\x02")
            end

            it "has UNIVERSAL tag class" do
              expect(subject.tag_class).to eq(tag_class::UNIVERSAL)
            end
          end

          context 'length' do
            subject { hp.new(enc).next.create_der.length }

            it "has length 1" do
              expect(subject.length).to eq(1)
            end
            it "is definite" do
              expect(subject.indefinite?).to eq(false)
            end
            it 'encodes to \x01' do
              expect(subject.encoding).to eq("\x01")
            end
          end

          context 'value' do
            subject { hp.new(enc).next.create_der.value }

            it { is_expected.to eq("\x2A") }
          end
        end

        context ':UNIVERSAL OCTET STRING complex length 2 bytes' do
          let(:enc) { "\x04\x82\x00\x01" << ("\xFF" * 256) }

          context 'tag' do
            subject { hp.new(enc).next.create_der.tag }

            it "has an OCTET_STRING tag" do
              expect(subject.tag).to eq(Krypt::Asn1::OCTET_STRING)
            end
            it "is primitive" do
              expect(subject.constructed?).to eq(false)
            end
            it 'encodes to \x04' do
              expect(subject.encoding).to eq("\x04")
            end

            it "has UNIVERSAL tag class" do
              expect(subject.tag_class).to eq(tag_class::UNIVERSAL)
            end
          end

          context 'length' do
            subject { hp.new(enc).next.create_der.length }

            it "has length 256" do
              expect(subject.length).to eq(256)
            end
            it "is definite" do
              expect(subject.indefinite?).to eq(false)
            end
            it 'encodes to \x82\x00\x01' do
              expect(subject.encoding).to eq("\x82\x00\x01")
            end
          end

          context 'value' do
            subject { hp.new(enc).next.create_der.value }

            it { is_expected.to eq("\xFF" * 256) }
          end
        end

        context ':UNIVERSAL complex tag 150 two bytes' do
          let(:enc) { "\xDF\x81\x16\x01\x01" }

          context 'tag' do
            subject { hp.new(enc).next.create_der.tag }

            it "has a tag of 150" do
              expect(subject.tag).to eq(150)
            end
            it "is primitive" do
              expect(subject.constructed?).to eq(false)
            end
            it 'encodes to \xDF\x81\x16' do
              expect(subject.encoding).to eq("\xDF\x81\x16")
            end

            it "has PRIVATE tag class" do
              expect(subject.tag_class).to eq(tag_class::PRIVATE)
            end
          end

          context 'length' do
            subject { hp.new(enc).next.create_der.length }

            it "has length 1" do
              expect(subject.length).to eq(1)
            end
            it "is definite" do
              expect(subject.indefinite?).to eq(false)
            end
            it 'encodes to \x01' do
              expect(subject.encoding).to eq("\x01")
            end
          end

          context 'value' do
            subject { hp.new(enc).next.create_der.value }

            it { is_expected.to eq("\x01") }
          end
        end

        context ':CONTEXT_SPECIFIC 0 IMPLICIT' do
          let(:enc) { "\x80\x01\x01" }

          context 'tag' do
            subject { hp.new(enc).next.create_der.tag }

            it "has a tag of 0" do
              expect(subject.tag).to eq(0)
            end
            it "is primitive" do
              expect(subject.constructed?).to eq(false)
            end
            it 'encodes to \x80' do
              expect(subject.encoding).to eq("\x80")
            end

            it "has CONTEXT_SPECIFIC tag class" do
              expect(subject.tag_class).to eq(tag_class::CONTEXT_SPECIFIC)
            end
          end
        end

        context ':CONTEXT_SPECIFIC 0 INTEGER 0 EXPLICIT' do
          let(:enc) { "\xA0\x03\x02\x01\x00" }

          context 'tag' do
            subject { hp.new(enc).next.create_der.tag }

            it "has a tag of 0" do
              expect(subject.tag).to eq(0)
            end
            it "is constructed" do
              expect(subject.constructed?).to eq(true)
            end
            it 'encodes to \xA0' do
              expect(subject.encoding).to eq("\xA0")
            end

            it "has CONTEXT_SPECIFIC tag class" do
              expect(subject.tag_class).to eq(tag_class::CONTEXT_SPECIFIC)
            end
          end
        end

        context ':APPLICATION 0' do
          let(:enc) { "\x40\x01\x00" }

          context 'tag' do
            subject { hp.new(enc).next.create_der.tag }

            it "has a tag of 0" do
              expect(subject.tag).to eq(0)
            end
            it "is primitive" do
              expect(subject.constructed?).to eq(false)
            end
            it 'encodes to \x40' do
              expect(subject.encoding).to eq("\x40")
            end

            it "has APPLICATION tag class" do
              expect(subject.tag_class).to eq(tag_class::APPLICATION)
            end
          end
        end

        context ':PRIVATE 0' do
          let(:enc) { "\xC0\x01\x00" }

          context 'tag' do
            subject { hp.new(enc).next.create_der.tag }

            it "has a tag of 0" do
              expect(subject.tag).to eq(0)
            end
            it "is primitive" do
              expect(subject.constructed?).to eq(false)
            end
            it 'encodes to \xC0' do
              expect(subject.encoding).to eq("\xC0")
            end

            it "has PRIVATE tag class" do
              expect(subject.tag_class).to eq(tag_class::PRIVATE)
            end
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
          subject { hp.new(enc).next.create_der.tag }

          it "has OCTET_STRING tag" do
            expect(subject.tag).to eq(Krypt::Asn1::OCTET_STRING)
          end
          it "is constructed" do
            expect(subject.constructed?).to eq(true)
          end
          it 'encodes to \x24' do
            expect(subject.encoding).to eq("\x24")
          end

          it "has UNIVERSAL tag class" do
            expect(subject.tag_class).to eq(tag_class::UNIVERSAL)
          end
        end

        context 'length' do
          subject { hp.new(enc).next.create_der.length }

          it "has length of nil" do
            expect(subject.length).to be_nil
          end
          it "is indefinite" do
            expect(subject.indefinite?).to eq(true)
          end
          it 'encodes to \x80' do
            expect(subject.encoding).to eq("\x80")
          end
        end

        context 'value' do
          subject { hp.new(enc).next.create_der.value }

          it { is_expected.to eq("\x04\x01\x01\x04\x01\x02\x00\x00") }
        end
      end

    end

  end

  context 'from IO' do

    context ':UNIVERSAL BOOLEAN true' do
      let(:enc) { StringIO.new("\x01\x01\xFF") }

      context 'tag' do
        subject { hp.new(enc).next.create_der.tag }

        it "has BOOLEAN tag" do
          expect(subject.tag).to eq(Krypt::Asn1::BOOLEAN)
        end
        it "is primitive" do
          expect(subject.constructed?).to eq(false)
        end
        it 'encodes to \x01' do
          expect(subject.encoding).to eq("\x01")
        end

        it "has UNIVERSAL tag class" do
          expect(subject.tag_class).to eq(tag_class::UNIVERSAL)
        end
      end

      context 'length' do
        subject { hp.new(enc).next.create_der.length }

        it "has length 1" do
          expect(subject.length).to eq(1)
        end
        it "is definite" do
          expect(subject.indefinite?).to eq(false)
        end
        it 'encodes to \x01' do
          expect(subject.encoding).to eq("\x01")
        end
      end

      context 'value' do
        subject { hp.new(enc).next.create_der.value }

        it { is_expected.to eq("\xFF") }
      end
    end

  end

  it 'raises for an invalid complex tag with bits 7 to 1 equal to zero' do
    expect { hp.new("\xDF\x80\x16\x01\x01").next }.to raise_error
  end

  it 'raises for an initial complex length octet 0xFF' do
    expect { hp.new("\x04\xFF").next }.to raise_error
  end

  pending 'raises for an unknown tag class' do
    fail
  end

  context 'allows to read the header value in a streaming manner with a buffer' do
    subject { hp.new(der).next.value_io.read(nil, buf) }

    context 'definite length' do
      let(:der) { "\x01\x01\xFF" }
      let(:buf) { "" }

      it { is_expected.to eq("\xFF") }
      it { is_expected.to eq(buf) }
    end

    context 'indefinite length' do
      let(:der) { "\x24\x80\x04\x01\x01\x00\x00" }
      let(:buf) { "" }

      it { is_expected.to eq("\x04\x01\x01\x00\x00") }
      it { is_expected.to eq(buf) }
    end

    context 'byte by byte' do
      subject { hp.new(der).next.value_io.read(1) }

      context 'definite length' do
        let(:der) { "\x02\x02\xFF\x00" }

        it { is_expected.to eq("\xFF") }
      end

      context 'indefinite length' do
        let(:der) { "\x24\x80\xDF\x81\x16\x01\x01\x00\x00" }

        it { is_expected.to eq("\xDF") }
      end
    end
  end

end

