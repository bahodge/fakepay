FactoryBot.define do
  factory :shipping_address do
    association :customer, factory: :customer
    name {"Human Business"}
    address {"123 Address Way, San Antonio, TX"}
    zip_code {"12345"}

  end
end