class FakepayApi::Connection

  FAKEPAY_API_KEY = ENV['FAKEPAY_API_KEY']

  attr_accessor :billing_token, :response

  def initialize(billing_token: nil, response: nil)
    @response = response
    @billing_token = billing_token
  end

  def self.from_customer(customer)
    FakepayApi::Connection.new(billing_token: customer.billing_token)
  end

  def build_headers
    {
        "Authorization" => "Token #{FAKEPAY_API_KEY}",
        "Content-Type" => "application/json",
        "Accept" => '*/*'
    }
  end

  def build_request(body: {}, message: :make_purchase)
    FakepayApi::Request.new(body: body,
                            headers: build_headers,
                            message: message)
  end

  def make_request!(body:)
    request = build_request(body: body)
    self.response = request.make_request!
    response
  end

end