# encoding: BINARY

require 'spec_helper'

describe Krypt::Rb::Asn1::Der::Tag do

  let(:tag) { Krypt::Rb::Asn1::Der::Tag }

  describe '#encoding' do

    subject { tag.new(tag: t, tag_class: tc) }

    context ':UNIVERSAL' do
      let(:tc) { :UNIVERSAL }

      context 'NULL' do
        let(:t) { tag::NULL }

        specify '05' do
          expect(subject.encoding).to eq("\x05")
        end
      end
    end

    context ':APPLICATION' do
      let(:tc) { :APPLICATION }

      context 'NULL' do
        let(:t) { tag::NULL }

        its(:encoding) { should eq("\x45") }
      end
    end

    context ':CONTEXT_SPECIFIC' do
      let(:tc) { :CONTEXT_SPECIFIC }

      context 'NULL' do
        let(:t) { tag::NULL }

        its(:encoding) { should eq("\x85") }
      end
    end

    context ':PRIVATE' do
      let(:tc) { :PRIVATE }

      context 'NULL' do
        let(:t) { tag::NULL }

        its(:encoding) { should eq("\xC5") }
      end

      context 'tag > 31 single byte: 32' do
        let(:t) { 32 }

        its(:encoding) { should eq("\xDF\x20") }
      end

      context 'tag > 31 two bytes 150' do
        let(:t) { 150 }

        its(:encoding) { should eq("\xDF\x81\x16") }
      end

      context 'tag > 31 three bytes 100.000' do
        let(:t) { 100_000 }

        its(:encoding) { should eq("\xDF\x86\x8D\x20") }
      end
    end

    context ':IMPLICIT' do
      let(:tc) { :IMPLICIT }

      context '0' do
        let(:t) { 0 }

        its(:encoding) { should eq("\x80") }
      end
    end

    context ':EXPLICIT' do
      let(:tc) { :EXPLICIT }

      context '0' do
        let(:t) { 0 }

        its(:encoding) { should eq("\xA0") }
      end
    end

  end
end

