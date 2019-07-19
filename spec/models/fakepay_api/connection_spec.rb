require 'rails_helper'

RSpec.describe FakepayApi::Connection do

  let(:amount) {1000}
  let(:card_number) {'42424242424242'}
  let(:cvv) {'123'}
  let(:expiration_month) {'01'}
  let(:expiration_year) {'2024'}
  let(:zip_code) {'12345'}

  let(:customer) {create(:customer)}

  let(:billing_info) do
    FakepayApi::Inputs::BillingInformation.new(amount: amount,
                                               customer: customer,
                                               card_number: card_number,
                                               cvv: cvv,
                                               expiration_month: expiration_month,
                                               expiration_year: expiration_year,
                                               zip_code: zip_code)
  end

  subject {described_class.from_customer(customer)}

  describe "#build_headers" do
    it "returns a hash" do
      result = subject.build_headers
      expect(result.has_key?("Authorization")).to be true
      expect(result.has_key?("Content-Type")).to be true
      expect(result.has_key?("Accept")).to be true
    end
  end

  describe '#build_request' do
    let(:body) {billing_info.to_h}
      it "returns a request object" do
        result = subject.build_request(body: body)
        expect(result.headers).to eq(subject.build_headers)
        expect(result.body).to eq(body)
      end
  end

  # mock aren't working right for some reason :(
  describe "#make_request!" do
    it "makes an http request to api"
  end


end