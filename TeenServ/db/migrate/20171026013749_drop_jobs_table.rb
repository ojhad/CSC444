class DropJobsTable < ActiveRecord::Migration[5.1]
  def change
    drop_table :jobs
  end
end
