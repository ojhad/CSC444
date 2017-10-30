class AddMoreColumnsToServices < ActiveRecord::Migration[5.1]
  def change
  	create_table :services_users do |t|
      t.belongs_to :user, foreign_key: true, null: false
      t.belongs_to :service, foreign_key: true, null: false
    end
    add_column :services , :min_age , :integer
    add_column :services , :max_age , :integer
  end
end
