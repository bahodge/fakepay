class CreateSubscriptions < ActiveRecord::Migration[5.2]
  def change
    create_table :subscriptions do |t|
      t.references :customer, optional: true
      t.string :name, null: false
      t.string :term, null: false
      t.string :status, null: false
      t.integer :price, default: 0, null:false
      t.datetime :purchased_at
      t.datetime :terminated_at

      t.timestamps
    end
  end
end
