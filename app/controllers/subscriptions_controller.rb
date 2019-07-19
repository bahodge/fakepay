class SubscriptionsController < ApplicationController

  skip_before_action :verify_authenticity_token # skipping token verification

  def create
    customer_id = params[:customer_id]
    customer = Customer.find_by_id(customer_id)
    return "No customer Id" unless customer

    subscription_id = params[:subscription_id]
    subscription = Subscription.find_by_id(subscription_id)
    return "No Subscription Id" unless subscription
    purchase_response = customer.subscribe_to_subscription!(params, subscription)

    render json: purchase_response
  end


end
