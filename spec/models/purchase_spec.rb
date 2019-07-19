require 'rails_helper'

RSpec.describe Purchase, type: :model do
  subject {create(:purchase)}

  describe "#to_h" do
    it "returns a hash" do
      result = subject.to_h
      expect(result[:id]).to eq(subject.id)
      expect(result[:status]).to eq(subject.status)
      expect(result[:purchased_at]).to eq(subject.purchased_at)
      expect(result[:responses]).to eq([])
    end

  end


end
