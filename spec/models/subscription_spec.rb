require 'rails_helper'

RSpec.describe Subscription, type: :model do

  subject { create(:subscription)}

  describe "#to_h" do
    it "returns a hash" do
      result = subject.to_h

      expect(result[:id]).to eq(subject.id)
      expect(result[:name]).to eq(subject.name)
      expect(result[:term]).to eq(subject.term)
      expect(result[:price]).to eq(subject.price)
    end
  end

end
