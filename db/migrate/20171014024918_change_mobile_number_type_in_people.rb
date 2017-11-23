class ChangeMobileNumberTypeInPeople < ActiveRecord::Migration[5.1]
  def change
    change_column :people, :mobile_number, :text
    change_column :people, :home_number, :text
  end
end
