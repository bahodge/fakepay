class CreatePurchases < ActiveRecord::Migration[5.2]
  def change
    create_table :purchases do |t|
      t.references :subscriber
      t.string :status, null: false
      t.datetime :purchased_at
      t.timestamps
    end
  end
end
