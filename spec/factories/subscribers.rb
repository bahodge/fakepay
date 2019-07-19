FactoryBot.define do
  factory :subscriber do
    association :subscription, factory: :subscription
    association :customer, factory: :customer
    status {"ACTIVE"}
    expires_at {10.days.from_now.end_of_day}

  end
end