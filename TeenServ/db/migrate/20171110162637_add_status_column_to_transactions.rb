class AddStatusColumnToTransactions < ActiveRecord::Migration[5.1]
  def change
    add_column :transactions, :status, :integer, null: false, default: 0
  end
end
