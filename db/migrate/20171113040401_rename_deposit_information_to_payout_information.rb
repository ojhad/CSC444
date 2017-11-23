class RenameDepositInformationToPayoutInformation < ActiveRecord::Migration[5.1]
  def change
    rename_table :deposit_informations, :payout_informations
  end
end
