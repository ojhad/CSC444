class AddMethodToDeposits < ActiveRecord::Migration[5.1]
  def change
    add_column :payout_informations, :method, :string , default: 'check'
  end
end
