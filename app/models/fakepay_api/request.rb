class FakepayApi::Request

  FAKEPAY_PURCHASE_ENDPOINT = ENV['FAKEPAY_PURCHASE_ENDPOINT']


  attr_accessor :body, :headers, :message, :endpoint

  def initialize(body: {}, headers:, message:)
    @body = body
    @headers = headers
    @message = message
    @endpoint = nil
  end

  def make_request!
    set_endpoint
    if good?
      HTTParty.post(self.endpoint, options)
    end
  end

  private

  def set_endpoint
    self.endpoint = self.message == :make_purchase ? FAKEPAY_PURCHASE_ENDPOINT : nil
  end

  def good?
    return false if self.body.empty?
    return false if self.endpoint.nil?
    true
  end

  def options
    {
        headers: headers,
        body: body.to_json
    }
  end

end