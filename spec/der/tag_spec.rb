# encoding: BINARY

require 'spec_helper'

describe Krypt::Asn1::Der::Tag do

  let(:tag) { Krypt::Asn1::Der::Tag }

  describe '#encoding' do

    subject { tag.new(tag: t, tag_class: tc) }

    context ':UNIVERSAL' do
      let(:tc) { :UNIVERSAL }

      context 'NULL' do
        let(:t) { Krypt::Asn1::NULL }

        it 'encodes to \x05' do
          expect(subject.encoding).to eq("\x05")
        end
      end
    end

    context ':APPLICATION' do
      let(:tc) { :APPLICATION }

      context 'NULL' do
        let(:t) { Krypt::Asn1::NULL }

        it 'encodes to \x45' do
          expect(subject.encoding).to eq("\x45")
        end
      end
    end

    context ':CONTEXT_SPECIFIC' do
      let(:tc) { :CONTEXT_SPECIFIC }

      context 'NULL' do
        let(:t) { Krypt::Asn1::NULL }

        it 'encodes to \x85' do
          expect(subject.encoding).to eq("\x85")
        end
      end
    end

    context ':PRIVATE' do
      let(:tc) { :PRIVATE }

      context 'NULL' do
        let(:t) { Krypt::Asn1::NULL }

        it 'encodes to \xC5' do
          expect(subject.encoding).to eq("\xC5")
        end
      end

      context 'tag > 31 single byte: 32' do
        let(:t) { 32 }

        it 'encodes to \xDF\x20' do
          expect(subject.encoding).to eq("\xDF\x20")
        end
      end

      context 'tag > 31 two bytes 150' do
        let(:t) { 150 }

        it 'encodes to \xDF\x81\x16' do
          expect(subject.encoding).to eq("\xDF\x81\x16")
        end
      end

      context 'tag > 31 three bytes 100.000' do
        let(:t) { 100_000 }

        it 'encodes to \xDF\x86\x8D\x20' do
          expect(subject.encoding).to eq("\xDF\x86\x8D\x20")
        end
      end
    end

  end
end

