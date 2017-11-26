class AddAddressColumnsToServices < ActiveRecord::Migration[5.1]
  def change
    add_column :services, :address_1, :string
    add_column :services, :address_2, :string
    add_column :services, :city, :string
    add_column :services, :province, :string
    add_column :services, :postal_code, :string
    add_column :services, :country, :string
    add_column :services, :latitude, :float
    add_column :services, :longitude, :float
  end
end
