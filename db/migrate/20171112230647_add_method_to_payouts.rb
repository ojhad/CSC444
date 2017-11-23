class AddMethodToPayouts < ActiveRecord::Migration[5.1]
  def change
    add_column :payouts, :method, :string
  end
end
