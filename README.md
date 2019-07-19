# Fakepay Api Challenge

### First off
- This was an awesome challenge
- I had a ton of fun
- I may have gone overboard, over-engineered and dove too deep, but in the end I'm super proud.
- Thanks for this :)

### Getting Started

- using `rails v5.2.3`
- using `postgres v11.4`
- using `ruby v2.6.2` 

- `cd path/to/project`
- `bundle install`
- `rails db:setup`
- `rails server`

### How the app works

- The app is already seeded with a little bit of info
- `SubscriptionsController` is the main controller for the api

## Enpoints

### CustomersController
- create POST
  - `name` => string
- delete DELETE
  - `customer_id` => integer
- subscriptions GET
  - `customer_id` => integer
- shipping_addresses GET
  - `customer_id` => integer
- customer_with_details GET
  - `customer_id` => integer
### ShippingAddressesController
- create POST
  - `name` => string
  - `zip_code` => string
  - `address` => string
  - `customer_id` => integer
- delete DELETE
  - `shipping_address_id` => integer
### SubscriptionsController
- subscribe POST
  - `customer_id`=> integer
  - `subscription_id`=> integer
  - `amount`=> integer
- create POST
  - `name` => string
  - `term` => string
  - `price` => integer
- list GET
  - `none_accepted`
- delete DELETE
  - `subscription_id` => integer

## Workflow
### First time Customer
  - Submit all billing information, customer, subscription
  - Customer calls to subscribe to subscription
  - Helper objects are built up to connect both the customer and the existing subscription.
  - The billing information is turned into a consumable payload for Fakepay
  - The Connection object is built and manages the request process
  - The response is parsed, stored and processed.
  - The customer then stores the new token received from successful purchase
  - Subscription info is updated
### Returning customer
  - Submit customer and subscription and amount
  - Customer has token still, doesn't need billing info large payload
  - Helper objects are updated
  - The Connection object is built and manages the request process
  - The response is parsed, stored and processed.
  - The customer then stores the any updated token received from successful purchase
  - Subscription info is updated
  
## Bonus
- [x] Customers can have multiple subscriptions
- [x] Create a script that can be run to renew subscriptions using cron `app/models/cron/renew_subscriptions.rb` 