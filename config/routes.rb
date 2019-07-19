Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get 'subscriptions/list', controller: :subscription
  post 'subscriptions/subscribe', controller: :subscription
  post 'subscriptions/create', controller: :subscription
  delete 'subscriptions/delete',  controller: :subscription

  get 'customers/customer_with_details', controller: :customer
  get 'customers/subscriptions', controller: :customer
  get 'customers/shipping_addresses', controller: :customer
  post 'customers/create', controller: :customer
  delete 'customers/delete', controller: :customer

  post 'shipping_addresses/create', controller: :shipping_address
  delete 'shipping_addresses/delete', controller: :shipping_address





end
