class SubscriptionsController < ApplicationController

  skip_before_action :verify_authenticity_token # skipping token verification

  def create
    customer_id = params[:customer_id]
    customer = Customer.find_by_id(customer_id)
    return render json: {error: "Cannot find customer with id #{customer_id}"} unless customer

    subscription_id = params[:subscription_id]
    subscription = Subscription.find_by_id(subscription_id)
    return "No Subscription Id" unless subscription
    return render json: {error: "No Subscription Id"} unless subscription

    render json: purchase_response
  end

  def list
    customer_id = params[:customer_id]
    customer = Customer.find_by_id(customer_id)
    return render json: {error: "Cannot find customer with id #{customer_id}"} unless customer

    render json: customer.subscribers.collect(&:to_h)
  end

  def delete
    customer_id = params[:customer_id]
    customer = Customer.find_by_id(customer_id)
    return render json: {error: "Cannot find customer with id #{customer_id}"} unless customer

    subscription_id = params[:subscription_id]
    subscription = Subscription.find_by_id(subscription_id)
    return render json: {error: "Cannot find Subscription with id #{subscription_id}"} unless subscription

    render json: customer.unsubscribe_from_subscription!(subscription)
  end


end
