require './app/models/application_record'
require './app/models/customer'
RSpec.describe Customer do

  subject {build(:customer)}
  let(:bad_customer) do
    c = build(:customer)
    c.name = nil
    c
  end

  describe "validations" do
    it {expect(subject.valid?).to be true}
    it {expect(bad_customer.valid?).to be false}
  end


end