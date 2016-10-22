# encoding: BINARY

require 'spec_helper'

RSpec.describe Krypt::ASN1::Set do

  describe "orders by tag when creating the SET" do

    describe "definite length" do

      subject { described_class.new(value).to_der }

      context "Array" do
        let (:value) { [
          Krypt::ASN1::Null.new,
          Krypt::ASN1::Integer.new(1),
          Krypt::ASN1::Boolean.new(true)
        ] }
        it { is_expected.to eq("\x31\x08\x01\x01\xFF\x02\x01\x01\x05\x00") }
      end

      context "Enumerable" do
        let(:value) {
          o = Object.new
          def o.each
            yield Krypt::ASN1::Null.new
            yield Krypt::ASN1::Integer.new(1)
            yield Krypt::ASN1::Boolean.new(true)
          end
          o
        }
        it { is_expected.to eq("\x31\x08\x01\x01\xFF\x02\x01\x01\x05\x00") }
      end

    end

    describe "infinite length" do

      subject { described_class.new(value, indefinite: true).to_der }

      context "Array" do
        let (:value) { [
          Krypt::ASN1::Null.new,
          Krypt::ASN1::Integer.new(1),
          Krypt::ASN1::Boolean.new(true)
        ] }

        it { is_expected.to eq("\x31\x80\x01\x01\xFF\x02\x01\x01\x05\x00\x00\x00") }
      end

      context "Enumerable" do
        let(:value) {
          o = Object.new
          def o.each
            yield Krypt::ASN1::Null.new
            yield Krypt::ASN1::Integer.new(1)
            yield Krypt::ASN1::Boolean.new(true)
          end
          o
        }

        it { is_expected.to eq("\x31\x80\x01\x01\xFF\x02\x01\x01\x05\x00\x00\x00") }
      end

    end

  end

  describe "orders in lexicographical order when creating the SET" do

    describe "definite length" do

      subject { described_class.new(value).to_der }

      context "Array" do
        let (:value) { [
          Krypt::ASN1::OctetString.new("aaaaaa"),
          Krypt::ASN1::OctetString.new("aaaab"),
          Krypt::ASN1::OctetString.new("aaa"),
          Krypt::ASN1::OctetString.new("b")
        ] }

        it { is_expected.to eq("\x31\x17\x04\x01b\x04\x03aaa\x04\x05aaaab\x04\x06aaaaaa") }
      end

      context "Enumerable" do
        let (:value) {
          o = Object.new
          def o.each
            yield Krypt::ASN1::OctetString.new("aaaaaa")
            yield Krypt::ASN1::OctetString.new("aaaab")
            yield Krypt::ASN1::OctetString.new("aaa")
            yield Krypt::ASN1::OctetString.new("b")
          end
          o
        }

        it { is_expected.to eq("\x31\x17\x04\x01b\x04\x03aaa\x04\x05aaaab\x04\x06aaaaaa") }
      end

    end

    describe "indefinite length" do

      subject { described_class.new(value, indefinite: true).to_der }

      context "Array" do
        let (:value) { [
          Krypt::ASN1::OctetString.new("aaaaaa"),
          Krypt::ASN1::OctetString.new("aaaab"),
          Krypt::ASN1::OctetString.new("aaa"),
          Krypt::ASN1::OctetString.new("b")
        ] }

        it { is_expected.to eq("\x31\x80\x04\x01b\x04\x03aaa\x04\x05aaaab\x04\x06aaaaaa\x00\x00") }
      end

      context "Enumerable" do
        let (:value) {
          o = Object.new
          def o.each
            yield Krypt::ASN1::OctetString.new("aaaaaa")
            yield Krypt::ASN1::OctetString.new("aaaab")
            yield Krypt::ASN1::OctetString.new("aaa")
            yield Krypt::ASN1::OctetString.new("b")
          end
          o
        }

        it { is_expected.to eq("\x31\x80\x04\x01b\x04\x03aaa\x04\x05aaaab\x04\x06aaaaaa\x00\x00") }
      end

    end
  end

  describe "keeps order from a parsed SET" do

    subject { Krypt::ASN1.decode(der).to_der }

    describe "definite length" do

      context "wrong tag order" do
        let(:der) { "\x31\x08\x02\x01\x01\x01\x01\xFF\x05\x00" }
        it { is_expected.to eq(der) }
      end

      context "wrong length order" do
        let(:der) { "\x31\x17\x04\x06aaaaaa\x04\x01b\x04\x03aaa\x04\x05aaaab" }
        it { is_expected.to eq(der) }
      end

    end

    describe "indefinite length" do

      context "wrong tag order" do
        let(:der) { "\x31\x80\x05\x00\x01\x01\xFF\x02\x01\x01\x00\x00" }
        it { is_expected.to eq(der) }
      end

      context "wrong length order" do
        let(:der) { "\x31\x80\x04\x06aaaaaa\x04\x01b\x04\x03aaa\x04\x05aaaab\x00\x00" }
        it { is_expected.to eq(der) }
      end

    end

  end
end

