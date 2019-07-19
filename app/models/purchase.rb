class Purchase < ApplicationRecord
  VALID_STATUSES = ["PENDING", "COMPLETE", "ERROR"]

  belongs_to :subscriber
  has_many :responses, dependent: :destroy

  after_initialize :set_defaults, unless: :persisted?

  validate :valid_status

  def set_defaults
    self.status ||= "PENDING"
    self.purchased_at ||= Time.zone.now
  end

  def valid_status
    return true if VALID_STATUSES.include?(self.status)
    false
  end
end
