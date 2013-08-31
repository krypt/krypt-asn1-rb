# encoding: BINARY

require 'spec_helper'

describe Krypt::Asn1::Rb::Asn1Object do

  let(:asn) { Krypt::Asn1::Rb::Asn1Object }
  let(:tag) { Krypt::Asn1::Rb::Tag }
  let(:len) { Krypt::Asn1::Rb::Length }

  describe '#encoding' do

    subject { asn.new(tag: t, tag_class: tc, constructed: cons, indefinite: indef, value: v) }

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

  end

end


