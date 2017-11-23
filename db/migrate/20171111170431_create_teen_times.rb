class CreateTeenTimes < ActiveRecord::Migration[5.1]
  def change
    create_table :teen_times do |t|
      t.integer :user_id
      t.string :day
      t.time :start_time
      t.time :end_time

      t.timestamps
    end
  end
end
