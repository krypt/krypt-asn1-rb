# encoding: BINARY

require 'spec_helper'

describe Krypt::Asn1::Der::Length do

  let(:len) { Krypt::Asn1::Der::Length }

  describe '#encoding' do

    context 'definite length' do
      subject { len.new(length: l) }

      context '<= 127' do

        context '0' do
          let(:l) { 0 }

          it 'encodes to \x00' do
            expect(subject.encoding).to eq("\x00")
          end
          it "is definite" do
            expect(subject.indefinite?).to eq(false)
          end
        end

        context '1' do
          let(:l) { 1 }

          it 'encodes to \x01' do
            expect(subject.encoding).to eq("\x01")
          end
          it "is definite" do
            expect(subject.indefinite?).to eq(false)
          end
        end

        context '42' do
          let(:l) { 42 }

          it 'encodes to \x2A' do
            expect(subject.encoding).to eq("\x2A")
          end
          it "is definite" do
            expect(subject.indefinite?).to eq(false)
          end
        end

        context '127' do
          let(:l) { 127 }

          it 'encodes to \x7F' do
            expect(subject.encoding).to eq("\x7F")
          end
          it "is definite" do
            expect(subject.indefinite?).to eq(false)
          end
        end
      end

      context '> 127' do

        context '128 (one byte)' do
          let(:l) { 128 }

          it 'encodes to \x81\x80' do
            expect(subject.encoding).to eq("\x81\x80")
          end
          it "is definite" do
            expect(subject.indefinite?).to eq(false)
          end
        end

        context '256 (two bytes)' do
          let(:l) { 256 }

          it 'encodes to \x82\x00\x01' do
            expect(subject.encoding).to eq("\x82\x00\x01")
          end
          it "is definite" do
            expect(subject.indefinite?).to eq(false)
          end
        end

        context '300 (two bytes)' do
          let(:l) { 300 }

          it 'encodes to \x82\x2C\x01' do
            expect(subject.encoding).to eq("\x82\x2C\x01")
          end
          it "is definite" do
            expect(subject.indefinite?).to eq(false)
          end
        end

        context '111.111 (three bytes)' do
          let(:l) { 111_111 }

          it 'encodes to \x83\x07\xB2\x01' do
            expect(subject.encoding).to eq("\x83\x07\xB2\x01")
          end
          it "is definite" do
            expect(subject.indefinite?).to eq(false)
          end
        end
      end

    end

    describe 'indefinite length' do

      subject { len.new(indefinite: true) }

      it 'encodes to \x80' do
        expect(subject.encoding).to eq("\x80")
      end
      it "is indefinite" do
        expect(subject.indefinite?).to eq(true)
      end
    end

  end
end
