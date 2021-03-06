class Customer < ApplicationRecord

  has_many :shipping_addresses, dependent: :destroy
  has_many :subscribers, dependent: :destroy
  has_many :purchases, through: :subscribers
  has_many :subscriptions, through: :subscribers

  after_initialize :set_defaults, unless: :persisted?

  def set_defaults
    self.name ||= ""
    self.billing_token ||= nil
  end

  def to_h
    {
        id: self.id,
        name: self.name,
        shipping_addresses: self.shipping_addresses.collect(&:to_h),
        subscribers: self.subscribers.collect(&:to_h)
    }
  end

  def build_billing_information(params)
    if self.billing_token.nil?
      FakepayApi::Inputs::BillingInformation.from_request(params, self)
    else
      amount = params[:amount]
      FakepayApi::Inputs::BillingInformation.from_customer(amount, self)
    end
  end

  def subscribe_to_subscription!(params, subscription)
    billing_info = build_billing_information(params)
    subscriber = find_or_create_subscriber_from_subscription!(subscription)
    purchase = subscriber.make_new_purchase!(billing_info)
    build_purchase_json_response(purchase, subscription)
  end

  def unsubscribe_from_subscription!(subscription)
    subscriber = find_subscriber_for_subscription(subscription)
    if subscriber
      subscriber.status = "TERMINATED"
      subscriber.save!
      {
          status: subscriber.status,
          expires_at: subscriber.expires_at,
          subscription_name: subscription.name,
          error: nil
      }
    else
      {
          status: nil,
          expires_at: nil,
          subscription_name: subscription.name,
          error: "Could not find customer subscriber"
      }
    end
  end

  private

  def build_purchase_json_response(purchase, subscription)
    response = purchase.responses.last
    if purchase.status == "COMPLETE"
      message = "Successfully subscribed to #{subscription.name}"
      error_message = nil
    else
      message = "Something went wrong :("
      error_message = response.error_message
    end
    subscriber = purchase.subscriber
    {
        status: purchase.status,
        purchased_at: purchase.purchased_at,
        expires_at: subscriber.expires_at,
        message: message,
        error_message: error_message
    }
  end

  def find_subscriber_for_subscription(subscription)
    self.subscribers.find do |subscriber|
      subscriber.subscription.id == subscription.id
    end
  end

  def find_or_create_subscriber_from_subscription!(subscription)
    subscriber = find_subscriber_for_subscription(subscription)
    unless subscriber
      subscriber = Subscriber.create!(customer: self,
                                      subscription: subscription)
    end
    subscriber
  end
end
