require 'rails_helper'

RSpec.describe SubscriptionsController, type: :controller do

  subject {described_class}

  describe "GET list" do
    let(:subscription) {create(:subscription)}
    before(:each) {subscription}
    it "returns a list of all subscriptions" do
      get :list
      body = JSON.parse(response.body)
      expected_response = JSON.parse(subscription.to_h.to_json)
      expect(body).to eq([expected_response])
    end
  end

  describe "POST create" do
    let(:name) {"New Plan"}
    let(:term) {"YEAR"}
    let(:price) {15784}
    let(:params) {{name: name, term: term, price: price}}
    it "creates a new subscription" do
      post :create, :params => params
      body = JSON.parse(response.body)
      expect(body["name"]).to eq(name)
      expect(body["price"]).to eq(price)
      expect(body["term"]).to eq(term)
    end
  end


  describe "DELETE delete" do
    let(:customer) {create(:customer)}
    let(:subscription) {create(:subscription)}
    let(:subscriber) {create(:subscriber, customer: customer, subscription: subscription)}
    let(:params) {{customer_id: customer.id, subscription_id: subscription.id}}

    before(:each) {subscriber}
    it "creates a new subscription" do
      delete :delete, :params => params
      body = JSON.parse(response.body)
      expect(body["status"]).to eq("TERMINATED")
      expect(body["expires_at"].to_date).to eq(subscriber.expires_at.to_date)
      expect(body["subscription_name"]).to eq(subscription.name)
      expect(body["error"]).to eq(nil)
    end
  end

  describe "POST subscribe" do
    let(:customer) {create(:customer)}
    let(:subscription) {create(:subscription)}
    let(:subscriber) {create(:subscriber, customer: customer, subscription: subscription)}
    let(:params) {{customer_id: customer.id, subscription_id: subscription.id}}

    let(:purchase_response) {
      {
          status: "COMPLETE",
          purchased_at: Time.zone.now,
          expires_at: 30.days.from_now,
          message: "SUCCESS",
          error_message: nil
      }
    }

    before(:each) {subscriber}
    it "creates a new subscription" do
      # mocks arent intercepting
      # expect(customer).to receive(:subscribe_to_subscription!).and_return(purchase_response)
      # post :subscribe, :params => params
      # body = JSON.parse(response.body)
      # puts body.inspect
    end
  end


end
