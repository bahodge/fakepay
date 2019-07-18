class ShippingAddress < ApplicationRecord

  belongs_to :customer, class_name: 'Customer'

  after_initialize :set_defaults, unless: :persisted?
  
  after_validation :set_unset_name

  def set_defaults
    self.zipcode ||= ''
    self.address ||= ''
    self.name ||= ''
  end

  def set_unset_name
    self.name = self.name.blank? ? customer.name : self.name
  end



end
