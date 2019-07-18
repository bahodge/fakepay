class FakepayApi::Inputs::Purchase

  attr_reader :amount, :card_number, :cvv, :expiration_month, :expiration_year, :zipcode

  def initialize(amount:, card_number:, cvv:, expiration_month:, expiration_year:, zipcode:)
    @amount = amount
    @card_number = card_number
    @cvv = cvv
    @expiration_month = expiration_month
    @expiration_year = expiration_year
    @zipcode = zipcode
  end

  def to_fakepay_payload
    {
        amount: self.amount,
        card_number: self.card_number,
        cvv: self.cvv,
        expiration_month: self.expiration_month,
        expiration_year: self.expiration_year,
        zipcode: self.zipcode
    }
  end
end