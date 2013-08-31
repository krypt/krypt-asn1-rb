# encoding: BINARY

require 'spec_helper'

describe Krypt::Asn1::Rb::HeaderParser do

  let(:hp) { Krypt::Asn1::Rb::HeaderParser }
  let(:tag) { Krypt::Asn1::Rb::Tag }
  let(:tag_class) { Krypt::Asn1::Rb::TagClass }

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

end

