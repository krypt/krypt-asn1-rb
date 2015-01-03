# encoding: BINARY

require 'spec_helper'

describe "Asn1 object equality" do

  let(:asn) { Krypt::Asn1 }

  subject { a == b && b == a } # ensure equality is commutative

  context "BOOLEAN" do
    context "equal" do
      context "when created from scratch" do
        let(:a) { asn::Boolean.new(true) }
        let(:b) { asn::Boolean.new(true) }
        it { is_expected.to eq(true) }
      end

      context "when parsed" do
        let(:a) { asn.decode("\x01\x01\xff") }
        let(:b) { asn.decode("\x01\x01\xff") }
        it { is_expected.to eq(true) }
      end
    end

    context "different" do
      context "when created from scratch" do
        let(:a) { asn::Boolean.new(true) }
        let(:b) { asn::Boolean.new(false) }
        it { is_expected.to eq(false) }
      end

      context "when parsed" do
        let(:a) { asn.decode("\x01\x01\xff") }
        let(:b) { asn.decode("\x01\x01\x00") }
        it { is_expected.to eq(false) }
      end

      context "when parsed, even if boolean value is the same" do
        let(:a) { asn.decode("\x01\x01\xff") }
        let(:b) { asn.decode("\x01\x01\xfe") }

        it { is_expected.to eq(false) }
        specify "although values are the same" do
          expect(a.value && a.value == b.value).to eq(true)
        end
      end
    end
  end

  context "SEQUENCE" do
    context "equal" do
      context "when created from scratch" do
        let(:a) { asn::Sequence.new([
          asn::Boolean.new(true),
          asn::Integer.new(42),
          asn::Ia5String.new("hello")
        ]) }
        let(:b) { asn::Sequence.new([
          asn::Boolean.new(true),
          asn::Integer.new(42),
          asn::Ia5String.new("hello")
        ]) }
        it { is_expected.to eq(true) }
      end

      context "when parsed" do
        let(:bytes) { "\x30\x0d\x01\x01\xff\x02\x01\x01\x16\x05hello" }
        let(:a) { asn.decode(bytes) }
        let(:b) { asn.decode(bytes) }
        it { is_expected.to eq(true) }
      end
    end

    context "different" do
      context "when created from scratch" do
        let(:a) { asn::Sequence.new([asn::Boolean.new(true)]) }
        let(:b) { asn::Sequence.new([asn::Integer.new(42)]) }
        it { is_expected.to eq(false) }
      end

      context "when created from scratch with equal content, but one is indefinite" do
        let(:a) { asn::Sequence.new([asn::Boolean.new(true)], indefinite: true) }
        let(:b) { asn::Sequence.new([asn::Boolean.new(true)]) }
        it { should eq(false) }
        specify "the encoding of its value is the same" do
          expect(a.value.first.to_der == b.value.first.to_der && a.value.size == b.value.size).to eq(true)
        end
      end

      context "when parsed" do
        let(:a) { asn.decode("\x30\x03\x02\x01\x01") }
        let(:b) { asn.decode("\x30\x03\x02\x01\x00") }
        it { is_expected.to eq(false) }
      end

      context "when parsed with equal content, but one is indefinite" do
        let(:a) { asn.decode("\x30\x03\x02\x01\x01") }
        let(:b) { asn.decode("\x30\x80\x02\x01\x01\x00\x00") }
        it { should eq(false) }
        specify "the encoding of its value is the same" do
          expect(a.value.first.value == b.value.first.value && a.value.first.value == 1).to eq(true)
        end
      end
    end
  end

end

