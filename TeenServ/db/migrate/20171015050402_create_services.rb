class CreateServices < ActiveRecord::Migration[5.1]
  def change
    create_table :services do |t|
      t.references :user, foreign_key: true
      t.string :service_title
      t.float :charge_per_hour
      t.integer :user_type

      t.timestamps
    end
  end
end
