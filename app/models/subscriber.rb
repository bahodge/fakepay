class Subscriber < ApplicationRecord

  VALID_STATUSES = ["ACTIVE", "INACTIVE", "TERMINATED"]

  belongs_to :customer
  belongs_to :subscription

  has_many :purchases, -> {order(purchased_at: :desc)}, dependent: :destroy
  has_many :responses, through: :purchases

  after_initialize :set_defaults, unless: :persisted?
  validate :valid_status

  def set_defaults
    self.status ||= "INACTIVE"
    self.expires_at ||= Time.zone.now
  end

  def valid_status
    unless VALID_STATUSES.include?(self.status)
      errors.add(:status, message: "Invalid status")
    end
  end

  # this should be an async job or subscription

  def make_new_purchase!(billing_info)
    purchase = Purchase.create!(subscriber: self)
    response = handle_request!(billing_info, purchase)
    response.update_purchase!
    update_customer_from_response!(response) if response.success?
    update_subscription!(response)
    purchase
  end

  def to_h
    {
        subscription_name: self.subscription.name,
        subscription_price: self.subscription.price,
        subscription_term: self.subscription.term,
        status: self.status,
        expires_at: self.expires_at
    }
  end

  private

  def update_subscription!(response)
    if response.success?
      self.status = "ACTIVE"
      update_expires_at
      self.save!
    end
  end

  def update_expires_at
    case self.subscription.term
    when "MONTH"
      time = 1.month.from_now.end_of_day
    when "YEAR"
      time = 1.year.from_now.end_of_day
    else
      time = 1.week.from_now.end_of_day
    end
    self.expires_at += time
  end

  def handle_request!(billing_info, purchase)
    connection = FakepayApi::Connection.from_customer(self.customer)
    http_response = connection.make_request!(body: billing_info.to_h)
    response = Response.from_http_response(http_response)
    response.purchase = purchase
    response.save!
    response
  end

  def update_customer_from_response!(response)
    self.customer.billing_token = response.token
    self.customer.save!
  end


end
