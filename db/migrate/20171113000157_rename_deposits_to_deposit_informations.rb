class RenameDepositsToDepositInformations < ActiveRecord::Migration[5.1]
  def change
    rename_table :deposits, :deposit_informations
  end
end
