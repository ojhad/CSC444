class AddBalanceAndPaypalToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :balance, :float , :default => 0.0
    add_column :users, :paypal, :string
  end
end
