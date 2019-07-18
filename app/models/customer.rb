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
