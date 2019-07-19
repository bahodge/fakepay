require 'rails_helper'

RSpec.describe ShippingAddressesController, type: :controller do

  describe "POST create" do
    let(:name) {"New Shipping Address"}
    let(:zip_code) {"12345"}
    let(:address) {"123 Main Street"}
    let(:customer) {create(:customer)}
    let(:params) {{customer_id: customer.id, name: name, zip_code: zip_code, address: address}}
    it "creates a new subscription" do
      post :create, :params => params
      body = JSON.parse(response.body)
      expect(body["name"]).to eq(name)
      expect(body["zip_code"]).to eq(zip_code)
      expect(body["address"]).to eq(address)
    end
  end


  describe "DELETE delete" do
    let(:shipping_address) { create(:shipping_address)}
    let(:params) {{shipping_address_id: shipping_address.id}}

    it "creates a new subscription" do
      delete :delete, :params => params
      body = JSON.parse(response.body)
      expect(body["status"]).to eq("DESTROYED")
      expect(body["shipping_address_id"].to_i).to eq(shipping_address.id)
    end
  end

end
