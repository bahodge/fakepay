class SubscriptionLibrary < ApplicationRecord
  VALID_TERMS = ["WEEK", "MONTH", "YEAR"]

  after_initialize :set_defaults, unless: :persisted?

  validate :valid_term

  def set_defaults
    self.name ||= ""
    self.term ||= "MONTH"
    self.price ||= 0
  end

  def valid_term
    unless VALID_TERMS.include?(self.term)
      errors.add(:term, message: "Invalid term")
    end
  end

end
