class AddDateToService < ActiveRecord::Migration[5.1]
  def change
    add_column :services, :date, :datetime
  end
end
