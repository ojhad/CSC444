class ChangePhoneTypeInUsers < ActiveRecord::Migration[5.1]
  def change
    change_column :users, :mobile_number, :string
    change_column :users, :home_number, :string
  end
end
