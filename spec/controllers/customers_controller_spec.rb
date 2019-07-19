require 'rails_helper'

RSpec.describe CustomersController, type: :controller do

  describe "GET subscriptions" do
    let(:customer) { create(:customer )}
    let(:params ) {{customer_id: customer.id}}
    let(:subscription) {create(:subscription)}
    let(:subscriber) {create(:subscriber, customer: customer, subscription: subscription)}
    before(:each) do
      subscriber
      subscription
    end
    it "returns a list of all subscriptions" do
      get :subscriptions, :params => params
      body = JSON.parse(response.body)
      expected_response = JSON.parse(subscription.to_h.to_json)
      expect(body).to eq([expected_response])
    end
  end

  describe "GET shipping_addresses" do
    let(:customer) { create(:customer )}
    let(:params ) {{customer_id: customer.id}}
    let(:shipping_address) {create(:shipping_address, customer: customer)}
    before(:each) do
      shipping_address
    end
    it "returns a list of all subscriptions" do
      get :shipping_addresses, :params => params
      body = JSON.parse(response.body)
      expected_response = JSON.parse(shipping_address.to_h.to_json)
      expect(body).to eq([expected_response])
    end
  end

  describe "GET customer_with_details" do
    let(:customer) { create(:customer )}
    let(:params ) {{customer_id: customer.id}}

    it "returns a list of all subscriptions" do
      get :customer_with_details, :params => params
      body = JSON.parse(response.body)
      expected_response = JSON.parse(customer.to_h.to_json)
      expect(body).to eq(expected_response)
    end
  end

  describe "POST create" do
    let(:name) { "Bobbo"}
    let(:params) {{name: name}}
    it "creates a customer" do
      post :create, :params => params
      body = JSON.parse(response.body)
      expect(body["name"]).to eq(name)
    end
  end

  describe "DELETE delete" do
    let(:customer) { create(:customer )}
    let(:params ) {{customer_id: customer.id}}
    it "destroys a customer" do
      delete :delete, :params => params
      body = JSON.parse(response.body)
      expect(body["customer_id"].to_i).to eq(customer.id)
      expect(body["status"]).to eq("DESTROYED")
    end
  end


end
