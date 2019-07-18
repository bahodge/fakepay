class Response < ApplicationRecord

  belongs_to :purchase

  before_save :set_error_message

  def self.from_http_response(response)
    Response.new(response_data: response.parsed_response)
  end

  def update_purchase!
    purchase.status = has_error? ? "ERROR" : "COMPLETE"
    purchase.save!
  end

  def has_error?
    return false if response_data.empty?
    error_code.present?
  end

  def success?
    return false unless success
    success.to_s == true.to_s
  end

  def set_error_message
    return unless has_error?
    case error_code
    when 1000001
      self.error_message = "Invalid credit card number"
    when 1000002
      self.error_message = "Insufficient funds"
    when 1000003
      self.error_message = "CVV failure"
    when 1000004
      self.error_message = "Expired card"
    when 1000005
      self.error_message = "Invalid zip code"
    when 1000006
      self.error_message = "Invalid purchase amount"
    when 1000007
      self.error_message = "Invalid token"
    when 1000008
      self.error_message = "Invalid params: cannot specify both token and other credit card params like  card_number, cvv, expiration_month, expiration_year or zip "
    else
      self.error_message = "Unknown error code"
    end
  end

  def success
    response_data["success"]
  end

  def error_code
    response_data["error_code"]
  end

  def token
    response_data["token"]
  end




end
