class AddMoneySplitsToFinance < ActiveRecord::Migration[5.1]
  def change
    rename_column :finances, :amount, :total_amount
    add_column :finances, :payout, :float
    add_column :finances, :credit_card_fee, :float
    add_column :finances, :profit, :float
  end
end
