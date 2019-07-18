class SubscriptionsController < ApplicationController

  skip_before_action :verify_authenticity_token # skipping token verification

  def create
    customer_id = params[:customer_id]
    customer = Customer.find_by_id(customer_id)
    return "No customer Id" unless customer

    subscription_id = params[:subscription_id]
    subscription = Subscription.find_by_id(subscription_id)
    return "No Subscription Id" unless subscription


    if customer.billing_token.nil?
      billing_info = FakepayApi::Inputs::BillingInformation.from_request(params, customer)
    else
      amount = params[:amount]
      billing_info = FakepayApi::Inputs::BillingInformation.from_customer(amount, customer)
    end

    subscriber = customer.find_or_create_subscriber_from_subscription!(subscription)
    purchase = subscriber.make_new_purchase!(billing_info)

    if purchase.status == "COMPLETE"
      message = "Successfully subscribed to #{subscription.name}"
      error_message = nil
    else
      message = "Something went wrong :("
      res = purchase.responses.last
      error_message = res.error_message
    end

    render json: {
        status: purchase.status,
        message: message,
        error_message: error_message
    }


  end


end
