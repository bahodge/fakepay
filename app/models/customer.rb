class Customer < ApplicationRecord
  has_many :shipping_addresses, dependent: :destroy

  after_initialize :set_defaults, unless: :persisted?
  
  def set_defaults
    self.name ||= ""
  end


end
