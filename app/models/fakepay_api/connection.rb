class FakepayApi::Connection

  FAKEPAY_API_KEY = ENV['FAKEPAY_API_KEY']

  attr_accessor :response

  def initialize(response: nil)
    @response = response
  end

  def build_headers
    # p headers: {"Authorization" => "Token token=\"111\""}
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

  def parse_response
    return unless self.response

  end


end