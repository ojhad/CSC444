class CreateServiceUsers < ActiveRecord::Migration[5.1]
  def change
  	drop_table :services_users
    create_table :service_users do |t|
      t.belongs_to :user, foreign_key: true, null: false
      t.belongs_to :service, foreign_key: true, null: false
      t.timestamps
    end
  end
end
