class ShippingAddress < ApplicationRecord

  belongs_to :customer

  after_initialize :set_defaults, unless: :persisted?
  after_validation :set_unset_name

  def set_defaults
    self.zip_code ||= ''
    self.address ||= ''
    self.name ||= ''
  end

  def set_unset_name
    if self.name.blank? && customer
      self.name = customer.name
    end
  end

  def to_h
    {
        id: self.id,
        name: self.name,
        address: self.address,
        zip_code: self.zip_code
    }
  end

end
