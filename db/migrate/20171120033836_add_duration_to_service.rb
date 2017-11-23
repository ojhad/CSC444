class AddDurationToService < ActiveRecord::Migration[5.1]
  def change
    add_column :services, :duration, :decimal
  end
end
