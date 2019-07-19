customer_1 = Customer.create!(name: "Ben Hodge")
customer_2 = Customer.create!(name: "Bobby Sue")

ShippingAddress.create!(customer: customer_1, name: "Ben", zip_code: "12345", address: "123 Main Street, San Antonio, TX")
ShippingAddress.create!(customer: customer_2, name: "Bobby Sue Doo", zip_code: "98765", address: "554 Local Ave., San Antonio, TX")

subscription_1 = Subscription.create!(name: "Bronze Box", term: "MONTH", price: 1999)
subscription_2 = Subscription.create!(name: "Silver Box", term: "MONTH", price: 4900)
subscription_3 = Subscription.create!(name: "Gold Box", term: "MONTH", price: 9900)

subscriber_1 = Subscriber.create(customer: customer_1, subscription: subscription_1, status: "TERMINATED")
subscriber_2 = Subscriber.create(customer: customer_1, subscription: subscription_2, status: "ACTIVE")
subscriber_3 = Subscriber.create(customer: customer_2, subscription: subscription_2, status: "ACTIVE")
subscriber_4 = Subscriber.create(customer: customer_2, subscription: subscription_3, status: "INACTIVE")

purchase_1 = Purchase.create!(subscriber: subscriber_1, status: "COMPLETE")
purchase_2 = Purchase.create!(subscriber: subscriber_2, status: "COMPLETE")
purchase_3 = Purchase.create!(subscriber: subscriber_3, status: "COMPLETE")
purchase_4 = Purchase.create!(subscriber: subscriber_4, status: "ERROR")

Response.create!(purchase: purchase_1, response_data: {"token" => "303c297da2938c786938d05e928d2e", "success" => true, "error_code" => nil})
Response.create!(purchase: purchase_2, response_data: {"token" => "303c297da2938c786938d05e928d2e", "success" => true, "error_code" => nil})
Response.create!(purchase: purchase_3, response_data: {"token" => "303c297da2938c786938d05e928d2e", "success" => true, "error_code" => nil})
Response.create!(purchase: purchase_4, response_data: {"token" => nil, "success" => false, "error_code" => 1000001})