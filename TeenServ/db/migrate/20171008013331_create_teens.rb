class CreateTeens < ActiveRecord::Migration[5.1]
  def change
    create_table :teens do |t|

      t.string :name
      t.string :email
      t.string :address_1
      t.string :address_2
      t.string :city
      t.string :province
      t.string :postal_code
      t.string :country
      t.integer :home_number
      t.integer :mobile_number
      t.integer :age
      t.string :profile_pic
      t.timestamps
    end
  end
end
