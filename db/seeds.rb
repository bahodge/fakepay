customer_1 = Customer.create!(name: "Ben")
customer_2 = Customer.create!(name: "Bobby Sue")

shipping_address_1 = ShippingAddress.create!(customer: customer_1,
                                             name: "Ben",
                                             zip_code: "12345",
                                             address: "123 Main Street, San Antonio, TX")

shipping_address_2 = ShippingAddress.create!(customer: customer_2,
                                             name: "Bobby Sue Doo",
                                             zip_code: "98765",
                                             address: "554 Local Ave., San Antonio, TX")

subscription_1 = Subscription.create!(name: "Bronze Box",
                                      term: "MONTH",
                                      price: 1999)

subscriber_1 = Subscriber.create(customer: customer_2,
                                 subscription: subscription_1,
                                 status: "ACTIVE")

purchase_1 = Purchase.create!(subscriber: subscriber_1,
                              status: "COMPLETE")

response_1 = Response.create!(purchase: purchase_1,
                              response_data: {"token" => "303c297da2938c786938d05e928d2e",
                                              "success" => true,
                                              "error_code" => nil})








