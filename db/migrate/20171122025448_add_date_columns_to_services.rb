class AddDateColumnsToServices < ActiveRecord::Migration[5.1]
  def change
    add_column :services, :start_time, :time
    add_column :services, :end_time, :time
    add_column :services, :day, :string
  end
end
