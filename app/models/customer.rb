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

  def subscribe_to_subscription!(params, subscription)
    if self.billing_token.nil?
      billing_info = FakepayApi::Inputs::BillingInformation.from_request(params, self)
    else
      amount = params[:amount]
      billing_info = FakepayApi::Inputs::BillingInformation.from_customer(amount, self)
    end

    subscriber = find_or_create_subscriber_from_subscription!(subscription)
    purchase = subscriber.make_new_purchase!(billing_info)
    build_purchase_json_response(purchase, subscription)
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

  def find_or_create_subscriber_from_subscription!(subscription)
    subscriber = self.subscribers.find do |subscriber|
      subscriber.subscription.id == subscription.id
    end
    unless subscriber
      subscriber = Subscriber.create!(customer: self,
                                      subscription: subscription)
    end
    subscriber
  end


end
