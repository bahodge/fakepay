require 'rails_helper'

RSpec.describe ShippingAddress, type: :model do

  subject { create(:shipping_address)}

  describe "#to_h" do
    it "returns a hash" do
      result = subject.to_h

      expect(result[:id]).to eq(subject.id)
      expect(result[:name]).to eq(subject.name)
      expect(result[:address]).to eq(subject.address)
      expect(result[:zip_code]).to eq(subject.zip_code)
    end
  end

end
