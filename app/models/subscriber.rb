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
  end

  def valid_status
    unless VALID_STATUSES.include?(self.status)
      errors.add(:status, message: "Invalid status")
    end
  end

  def make_new_purchase!(billing_info)
    purchase = Purchase.create!(subscriber: self)
    response = handle_request!(billing_info, purchase)
    response.update_purchase!
    update_customer_from_response!(response) if response.success?
    purchase
  end

  private

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
