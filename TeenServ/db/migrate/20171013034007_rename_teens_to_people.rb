class RenameTeensToPeople < ActiveRecord::Migration[5.1]
  def change
    rename_table :teens, :people
  end
end
