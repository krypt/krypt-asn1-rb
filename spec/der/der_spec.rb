# encoding: BINARY

require 'spec_helper'

describe Krypt::Asn1::Der do

  let(:der) { Krypt::Asn1::Der }
  let(:tag) { Krypt::Asn1::Der::Tag }
  let(:len) { Krypt::Asn1::Der::Length }

  describe '#encoding' do

    subject { der.new(tag: t, tag_class: tc, constructed: cons, indefinite: indef, value: v) }

    context 'definite length' do
      let(:indef) { false }

      context 'primitive' do
        let(:cons) { false }

        context ':UNIVERSAL' do
          let(:tc) { :UNIVERSAL }

          context 'INTEGER' do
            let(:t) { tag::INTEGER }
            
            context '0' do
              let(:v) { "\x00" }
              its(:encoding) { should eq("\x02\x01\x00") }
            end

            context '42' do
              let(:v) { "\x01\x02" }
              its(:encoding) { should eq("\x02\x02\x01\x02") }
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
          let(:tc) { :UNIVERSAL }

          context 'OCTET STRING' do
            let(:t) { tag::OCTET_STRING }
            
            context '07' do
              let(:v) { "\x04\x01\x07\x00\x00" }
              its(:encoding) { should eq("\x24\x80\x04\x01\x07\x00\x00") }
            end
          end

        end

      end

    end

  end

end


