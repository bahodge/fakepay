class ShippingAddress < ApplicationRecord

  belongs_to :customer

  after_initialize :set_defaults, unless: :persisted?
  after_validation :set_unset_name

  def set_defaults
    self.zipcode ||= ''
    self.address ||= ''
    self.name ||= ''
  end

  def set_unset_name
    if self.name.blank? && customer
      self.name = customer.name
    end
  end

  def to_payload
    {zipcode: self.zipcode, name: self.name, address: self.address}
  end


end
