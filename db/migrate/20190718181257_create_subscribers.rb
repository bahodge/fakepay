class CreateSubscribers < ActiveRecord::Migration[5.2]
  def change
    create_table :subscribers do |t|
      t.references :subscription
      t.references :customer
      t.string :status, null: false
      t.datetime :expires_at

      t.timestamps
    end
  end
end
