class AddMethodToDeposits < ActiveRecord::Migration[5.1]
  def change
    add_column :deposits, :method, :string , default: 'check'
  end
end
