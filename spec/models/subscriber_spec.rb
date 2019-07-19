require 'rails_helper'

RSpec.describe Subscriber, type: :model do

  subject { create(:subscriber, status: "INACTIVE")}

  describe "#to_h" do
    it "returns a hash" do
      result = subject.to_h

      expect(result[:subscription_name]).to eq(subject.subscription.name)
      expect(result[:subscription_price]).to eq(subject.subscription.price)
      expect(result[:subscription_term]).to eq(subject.subscription.term)
      expect(result[:status]).to eq(subject.status)
      expect(result[:expires_at].to_date).to eq(subject.expires_at.to_date)
      expect(result[:purchases]).to eq([])
    end
  end

  describe "#make_new_purchase!" do
    let(:response) {create(:response)}
    it "makes a new purchase" do
      expect(subject.purchases).to eq([])
      expect(subject.customer.billing_token).to be_nil
      expect(subject.status).to_not eq("ACTIVE")

      expect(subject).to receive(:handle_request!).and_return(response)

      subject.make_new_purchase!(nil)
      subject.reload

      expect(subject.purchases).to_not eq([])
      expect(subject.customer.billing_token).to_not be_nil
      expect(subject.status).to eq("ACTIVE")
    end
  end




end
