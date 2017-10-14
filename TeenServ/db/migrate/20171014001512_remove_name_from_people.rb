class RemoveNameFromPeople < ActiveRecord::Migration[5.1]
  def change
    remove_column :people , :name
  end
end

