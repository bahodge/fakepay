class CreateSubscriptionLibraries < ActiveRecord::Migration[5.2]
  def change
    create_table :subscription_libraries do |t|
      t.string :name, null: false
      t.string :term, null: false
      t.integer :price, default: 0, null:false

      t.timestamps
    end
  end
end
