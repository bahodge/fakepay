class CustomersController < ApplicationController

  skip_before_action :verify_authenticity_token # skipping token verification

  def subscriptions
    customer_id = params[:customer_id]
    customer = Customer.find_by_id(customer_id)
    return render json: {error: "Cannot find customer with id #{customer_id}"} unless customer

    render json: customer.subscribers.collect(&:to_h)
  end

  def shipping_addresses
    customer_id = params[:customer_id]
    customer = Customer.find_by_id(customer_id)
    return render json: {error: "Cannot find customer with id #{customer_id}"} unless customer

    render json: customer.shipping_addresses.collect(&:to_h)
  end

  def customer_with_details
    customer_id = params[:customer_id]
    customer = Customer.find_by_id(customer_id)
    return render json: {error: "Cannot find customer with id #{customer_id}"} unless customer

    render json: customer.to_h
  end

  def create
    name = params[:name]
    customer = Customer.create!(name: name)

    render json: customer.to_h
  end

  def delete
    customer_id = params[:customer_id]
    customer = Customer.find_by_id(customer_id)
    return render json: {error: "Cannot find customer with id #{customer_id}"} unless customer

    customer.destroy!

    render json: {customer_id: customer_id, status: "DESTROYED"}
  end


end
