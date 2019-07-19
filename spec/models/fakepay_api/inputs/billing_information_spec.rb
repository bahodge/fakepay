require 'rails_helper'

RSpec.describe FakepayApi::Inputs::BillingInformation do

  let(:customer) {create(:customer)}
  let(:amount) {1000}
  let(:card_number) {'42424242424242'}
  let(:cvv) {'123'}
  let(:expiration_month) {'01'}
  let(:expiration_year) {'2024'}
  let(:zip_code) {'12345'}


  subject do
    FakepayApi::Inputs::BillingInformation.new(amount: amount,
                                               customer: customer,
                                               card_number: card_number,
                                               cvv: cvv,
                                               expiration_month: expiration_month,
                                               expiration_year: expiration_year,
                                               zip_code: zip_code)
  end

  describe "#to_h" do
    context "if billing_token" do
      subject do
        FakepayApi::Inputs::BillingInformation.new(billing_token: customer.billing_token,
                                                   customer: customer,
                                                   amount: amount)
      end
      it "returns a token hash" do
        result = subject.to_h
        expect(result[:billing_token]).to eq(subject.billing_token)
        expect(result[:customer_id]).to eq(subject.customer.id)
        expect(result[:amount]).to eq(subject.amount)
      end
    end

    context "if no billing token" do
      it "returns a full hash" do
        result = subject.to_h
        expect(result[:amount]).to eq(subject.amount)
        expect(result[:customer_id]).to eq(subject.customer.id)
        expect(result[:card_number]).to eq(subject.card_number)
        expect(result[:cvv]).to eq(subject.cvv)
        expect(result[:expiration_month]).to eq(subject.expiration_month)
        expect(result[:expiration_year]).to eq(subject.expiration_year)
        expect(result[:zip_code]).to eq(subject.zip_code)
      end
    end
  end

end