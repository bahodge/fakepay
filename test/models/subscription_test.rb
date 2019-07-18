require 'test_helper'

class SubscriptionTest < ActiveSupport::TestCase

  name = "Test Subscription"
  term = "MONTH"
  status = "ACTIVE"
  price = 1999
  customer = Customer.create!(name: "Bob")
  valid_subscription = Subscription.new(customer: customer,
                                        name: name,
                                        term: term,
                                        status: status,
                                        price: price)

  test 'status_validation' do

    assert valid_subscription.valid?
  end

  # test "the truth" do
  #   assert true
  # end
end
