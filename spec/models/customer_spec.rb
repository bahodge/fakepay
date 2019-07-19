require 'rails_helper'
# require './app/models/application_record'
# require './app/models/customer'
RSpec.describe Customer do

  subject {create(:customer)}
  let(:subscription) {create(:subscription)}

  let(:amount) {1000}
  let(:card_number) {'42424242424242'}
  let(:cvv) {'123'}
  let(:expiration_month) {'01'}
  let(:expiration_year) {'2024'}
  let(:zip_code) {'12345'}

  let(:params) {
    {
        amount: amount,
        card_number: card_number,
        cvv: cvv,
        expiration_month: expiration_month,
        expiration_year: expiration_year,
        zip_code: zip_code
    }
  }

  describe "validations" do
    it {expect(subject.valid?).to be true}
  end

  describe "#to_h" do
    subject {create(:customer)}
    it "returns a hash" do
      result = subject.to_h
      expect(result[:id]).to eq(subject.id)
      expect(result[:name]).to eq(subject.name)
      expect(result[:shipping_addresses]).to eq([])
      expect(result[:subscribers]).to eq([])
    end
  end

  describe "#build_billing_information" do

    context "with billing_token" do
      it "returns a billing information object" do
        result = subject.build_billing_information(params)

        expect(result.customer).to eq(subject)
        expect(result.amount).to eq(amount)

        expect(result.billing_token).to be_nil
        expect(result.card_number).to eq(card_number)
        expect(result.cvv).to eq(cvv)
        expect(result.expiration_month).to eq(expiration_month)
        expect(result.expiration_year).to eq(expiration_year)
        expect(result.zip_code).to eq(zip_code)

      end
    end
    context "without billing_token" do
      subject {build(:customer_with_billing_token)}
      it "returns a billing information object" do
        result = subject.build_billing_information(params)

        expect(result.customer).to eq(subject)
        expect(result.amount).to eq(amount)
        expect(result.billing_token).to eq(subject.billing_token)

        expect(result.card_number).to be_nil
        expect(result.cvv).to be_nil
        expect(result.expiration_month).to be_nil
        expect(result.expiration_year).to be_nil
        expect(result.zip_code).to be_nil
      end
    end
  end

  describe "#subscribe_to_subscription!" do

    let(:subscriber) do
      create(:subscriber,
             customer: subject,
             subscription: subscription)
    end

    let(:mocked_result) {
      {
          status: "COMPLETE",
          purchased_at: Time.zone.now,
          expires_at: 30.days.from_now,
          message: "Successfully subscribed to Bronze Plan",
          error_message: nil
      }
    }

    let(:purchase) {create(:purchase, subscriber: subscriber)}
    before(:each) do
      subscriber
    end
    # it "subscribes to subscription" do
    #   expect(subject.subscribers).to eq([subscriber])
    #
    #   expect(subscriber).to receive(:make_new_purchase!).and_return(purchase)
    #
    #   result = subject.subscribe_to_subscription!(params, subscription)
    #
    #   expect(subject.subscribers.length).to eq(1)
    #   expect(result[:status]).to eq("COMPLETE")
    #   expect(result[:purchased_at].to_date).to eq(purchase.purchased_at.to_date)
    #   expect(result[:expires_at].to_date).to eq(subscriber.expires_at.to_date)
    #   expect(result[:message]).to eq("Successfully subscribed to #{subscription.name}")
    #   expect(result[:error_message]).to be_nil
    # end
  end

  describe "unsubscribe_from_subscription!" do
    context "with subscriber" do
      let(:subscriber) do
        create(:subscriber,
               customer: subject,
               subscription: subscription)
      end
      before(:each) do
        subscriber
      end

      it "returns hash" do
        expect(subject.subscribers).to eq([subscriber])

        result = subject.unsubscribe_from_subscription!(subscription)
        p subscriber

        expect(result[:status]).to eq("TERMINATED")
        expect(result[:expires_at].to_date).to eq(subscriber.expires_at.to_date)
        expect(result[:subscription_name]).to eq(subscription.name)
        expect(result[:error]).to be_nil
      end
    end
    context "without subscriber" do
      it "returns hash" do
        result = subject.unsubscribe_from_subscription!(subscription)
        expect(result[:status]).to be_nil
        expect(result[:expires_at]).to be_nil
        expect(result[:subscription_name]).to eq(subscription.name)
        expect(result[:error]).to eq("Could not find customer subscriber")
      end
    end
  end


end