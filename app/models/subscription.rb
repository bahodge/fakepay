class Subscription < ApplicationRecord
  VALID_TERMS = ["WEEK", "MONTH", "YEAR"]

  has_many :subscribers, dependent: :destroy

  after_initialize :set_defaults, unless: :persisted?

  validate :valid_term

  def valid_term
    unless VALID_TERMS.include?(self.term)
      errors.add(:term, message: "Invalid term")
    end
  end


  def set_defaults
    self.name ||= ""
    self.term ||= "MONTH"
    self.status ||= "INACTIVE"
    self.price ||= 0
  end

end
