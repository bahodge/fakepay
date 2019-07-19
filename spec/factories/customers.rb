FactoryBot.define do
  factory :customer do
    name {"Human Minion"}
    billing_token {nil}
    factory :customer_with_billing_token do
      billing_token {"123456789113"}
    end
  end
end