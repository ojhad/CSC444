class CreateTransactions < ActiveRecord::Migration[5.1]
  def change
    create_table :transactions do |t|
      t.float :total_amount
      t.float :number_of_hours
      t.float :charge_per_hour
      t.text :service_title
      t.references :teen
      t.references :client
    end
    add_reference :transactions, :service, foreign_key: true
    add_foreign_key :transactions, :users, column: :teen_id, primary_key: :id
    add_foreign_key :transactions, :users, column: :client_id, primary_key: :id
  end
end
