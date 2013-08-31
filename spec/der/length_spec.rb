# encoding: BINARY

require 'spec_helper'

describe Krypt::Rb::Asn1::Der::Length do

  let(:len) { Krypt::Rb::Asn1::Der::Length }

  describe '#encoding' do

    context 'definite length' do
      subject { len.new(length: l) }

      context '<= 127' do 

        context '0' do
          let(:l) { 0 }

          its(:encoding) { should eq("\x00") }
          its(:indefinite?) { should be_false }
        end

        context '1' do
          let(:l) { 1 }

          its(:encoding) { should eq("\x01") }
          its(:indefinite?) { should be_false }
        end

        context '42' do
          let(:l) { 42 }

          its(:encoding) { should eq("\x2A") }
          its(:indefinite?) { should be_false }
        end

        context '127' do
          let(:l) { 127 }

          its(:encoding) { should eq("\x7F") }
          its(:indefinite?) { should be_false }
        end
      end

      context '> 127' do

        context '128 (one byte)' do
          let(:l) { 128 }

          its(:encoding) { should eq("\x81\x80") }
          its(:indefinite?) { should be_false }
        end

        context '256 (two bytes)' do
          let(:l) { 256 }

          its(:encoding) { should eq("\x82\x00\x01") }
          its(:indefinite?) { should be_false }
        end

        context '300 (two bytes)' do
          let(:l) { 300 }

          its(:encoding) { should eq("\x82\x2C\x01") }
          its(:indefinite?) { should be_false }
        end

        context '111.111 (three bytes)' do
          let(:l) { 111_111 }

          its(:encoding) { should eq("\x83\x07\xB2\x01") }
          its(:indefinite?) { should be_false }
        end
      end

    end

    describe 'indefinite length' do

      subject { len.new(indefinite: true) }

      its(:encoding) { should eq("\x80") }
      its(:indefinite?) { should be_true }
    end

  end
end
