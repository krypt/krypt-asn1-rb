# encoding: BINARY

require 'spec_helper'

RSpec.describe Krypt::ASN1::Der do

  let(:der) { Krypt::ASN1::Der }
  let(:tag) { Krypt::ASN1::Der::Tag }
  let(:tag_class) { Krypt::ASN1::Der::TagClass }
  let(:len) { Krypt::ASN1::Der::Length }

  describe '#to_der' do

    subject { der.new(tag: t, tag_class: tc, constructed: cons, indefinite: indef, value: v) }

    context 'definite length' do
      let(:indef) { false }

      context 'primitive' do
        let(:cons) { false }

        context ':UNIVERSAL' do
          let(:tc) { tag_class::UNIVERSAL }

          context 'INTEGER' do
            let(:t) { Krypt::ASN1::INTEGER }

            context '0' do
              let(:v) { "\x00" }
              it 'should encode to \x02\x01\x00' do
                expect(subject.to_der).to eq("\x02\x01\x00")
              end
            end

            context '42' do
              let(:v) { "\x01\x02" }
              it 'should encode to \x02\x02\x01\x02' do
                expect(subject.to_der).to eq("\x02\x02\x01\x02")
              end
            end
          end

        end

      end
    end

    context 'indefinite length' do
      let(:indef) { true }

      context 'constructed' do
        let(:cons) { true }

        context ':UNIVERSAL' do
          let(:tc) { tag_class::UNIVERSAL }

          context 'OCTET STRING' do
            let(:t) { Krypt::ASN1::OCTET_STRING }

            context '07' do
              let(:v) { "\x04\x01\x07\x00\x00" }

              it 'should encode to \x24\x80\x04\x01\x07\x00\x00' do
                expect(subject.to_der).to eq("\x24\x80\x04\x01\x07\x00\x00")
              end
            end
          end

        end

      end

    end

  end

end

