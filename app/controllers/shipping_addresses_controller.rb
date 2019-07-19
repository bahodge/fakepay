class ShippingAddressesController < ApplicationController

  skip_before_action :verify_authenticity_token # skipping token verification


  def create
    customer_id = params[:customer_id]
    customer = Customer.find_by_id(customer_id)
    return render json: {error: "Cannot find customer with id #{customer_id}"} unless customer

    shipping_address = ShippingAddress.create!(customer: customer,
                                               zip_code: params[:zip_code],
                                               address: params[:address],
                                               name: params[:name])

    render json: shipping_address.to_h
  end

  def delete
    shipping_address_id = params[:shipping_address_id]
    shipping_address = Customer.find_by_id(shipping_address_id)
    unless shipping_address
      render json: {error: "Cannot find Shipping Address with id #{shipping_address_id}"}
    end

    shipping_address.destroy!

    render json: {shipping_address_id: shipping_address_id, status: "DESTROYED"}
  end

end
