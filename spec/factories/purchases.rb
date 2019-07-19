FactoryBot.define do
  factory :purchase do
    association :subscriber, factory: :subscriber
    status {"PENDING"}
    purchased_at {Time.zone.now}

  end
end