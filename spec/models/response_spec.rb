require 'rails_helper'

RSpec.describe Response, type: :model do

  subject {create(:response)}
  let(:error_response_data) { {"token" => nil, "success" => false, "error_code" => 00000001}}

  describe "#to_h" do
    it "returns a hash" do
      result = subject.to_h
      expect(result[:id]).to eq(subject.id)
      expect(result[:response_data]).to eq(subject.response_data)
    end
  end

  describe "#update_purchase!" do
    context "with error" do
      before(:each) do
        subject.response_data = error_response_data
        subject.save!
      end
      it "updates purchase status" do
        expect(subject.purchase.status).to eq("PENDING")
        subject.update_purchase!
        expect(subject.purchase.status).to eq("ERROR")
      end
    end
    context "without error" do
      it "updates purchase status" do
        expect(subject.purchase.status).to eq("PENDING")
        subject.update_purchase!
        expect(subject.purchase.status).to eq("COMPLETE")
      end
    end
  end

  describe "#has_error?" do
  let(:bad_response) {build(:response, response_data: error_response_data)}
    it {expect(subject.has_error?).to be false}
    it {expect(bad_response.has_error?).to be true}
  end

  describe "#success?" do
      let(:bad_response) {build(:response, response_data: error_response_data)}
      it {expect(subject.success?).to be true}
      it {expect(bad_response.success?).to be false}
  end



end
