class AddBillingTokenToCustomer < ActiveRecord::Migration[5.2]
  def change
    add_column :customers, :billing_token, :string, null: true
  end
end
