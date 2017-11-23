class AddFirstNameLastNameToPeople < ActiveRecord::Migration[5.1]
  def change
    add_column :people , :first_name , :string
    add_column :people , :last_name , :string
  end
end
