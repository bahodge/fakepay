class FakepayApi::Inputs::BillingInformation

  attr_reader :amount,
              :card_number,
              :cvv,
              :expiration_month,
              :expiration_year,
              :zip_code,
              :billing_token,
              :customer

  def initialize(amount:,
                 customer:,
                 billing_token: nil,
                 card_number: nil,
                 cvv: nil,
                 expiration_month: nil,
                 expiration_year: nil,
                 zip_code: nil)
    @amount = amount
    @customer = customer
    @card_number = card_number
    @cvv = cvv
    @expiration_month = expiration_month
    @expiration_year = expiration_year
    @zip_code = zip_code
    @billing_token = billing_token
  end

  def self.from_request(params, customer)
    FakepayApi::Inputs::BillingInformation.new(customer: customer,
                                               amount: params[:amount],
                                               card_number: params[:card_number],
                                               cvv: params[:cvv],
                                               expiration_month: params[:expiration_month],
                                               expiration_year: params[:expiration_year],
                                               zip_code: params[:zip_code])
  end

  def self.from_customer(amount, customer)
    FakepayApi::Inputs::BillingInformation.new(customer: customer,
                                               amount: amount,
                                               billing_token: customer.billing_token)
  end

  def to_h
    if customer.billing_token.nil?
      {
          card_number: self.card_number,
          cvv: self.cvv,
          expiration_month: self.expiration_month,
          expiration_year: self.expiration_year,
          zip_code: self.zip_code,
          customer_id: self.customer.id,
          amount: self.amount
      }
    else
      {
          amount: self.amount,
          customer_id: self.customer.id,
          token: self.customer.billing_token
      }
    end

  end
end