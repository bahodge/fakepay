class Subscription < ApplicationRecord
  VALID_TERMS = ["WEEK", "MONTH", "YEAR"]
  VALID_STATUSES = ["ACTIVE", "INACTIVE", "TERMINATED"]

  belongs_to :customer

  after_initialize :set_defaults, unless: :persisted?

  validate :valid_term
  validate :valid_status

  def valid_term
    unless VALID_TERMS.include?(self.term)
      errors.add(:term, message: "Invalid term")
    end
  end

  def valid_status
    unless VALID_STATUSES.include?(self.status)
      errors.add(:status, message: "Invalid status")
    end
  end

  def set_defaults
    self.name ||= ""
    self.term ||= "MONTH"
    self.status ||= "INACTIVE"
    self.price ||= 0
  end

  def from_subscription_library(subscription_library: )
    Subscription.new(name: subscription_library.name,
                     term: subscription_library.term,
                     price: subscription_library.price,
                     status: "INACTIVE")
  end
end
