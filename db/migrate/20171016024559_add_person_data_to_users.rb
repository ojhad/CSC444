class AddPersonDataToUsers < ActiveRecord::Migration[5.1]
  def change
  	add_column :users, :name, :string
	add_column :users, :address_1, :string
	add_column :users, :address_2, :string
	add_column :users, :city, :string
	add_column :users, :province, :string
	add_column :users, :postal_code, :string
	add_column :users, :country, :string
	add_column :users, :home_number, :integer
	add_column :users, :mobile_number, :integer
	add_column :users, :age, :integer
	add_column :users, :profile_pic, :string
	add_column :users, :type, :string
  end
end
