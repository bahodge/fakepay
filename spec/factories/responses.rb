FactoryBot.define do
  factory :response do
    association :purchase, factory: :purchase
    response_data { {"token" => '12356789', "success" => true, "error_code" => nil}}
  end
end