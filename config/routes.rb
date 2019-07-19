Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  post 'subscriptions/create', controller: :subscription
  get 'subscriptions/list', controller: :subscription
  post 'subscriptions/delete',  controller: :subscription

end
