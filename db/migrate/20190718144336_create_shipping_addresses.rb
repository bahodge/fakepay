class CreateShippingAddresses < ActiveRecord::Migration[5.2]
  def change
    create_table :shipping_addresses do |t|
      t.references :customer
      t.string :name, null: false
      t.string :zipcode, null: false
      t.string :address, null: false
      t.timestamps
    end
  end
end
