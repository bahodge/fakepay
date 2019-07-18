class CreateResponses < ActiveRecord::Migration[5.2]
  def change
    create_table :responses do |t|
      t.references :purchase
      t.string :error_message, null: true
      t.jsonb :response_data
      t.timestamps
    end
  end
end
