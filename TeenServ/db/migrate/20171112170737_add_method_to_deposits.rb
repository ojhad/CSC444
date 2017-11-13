class AddMethodToDeposits < ActiveRecord::Migration[5.1]
  def change
    add_column :deposit_information, :method, :string , default: 'check'
  end
end
