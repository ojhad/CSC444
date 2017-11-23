class ChangeTypeToGroupInPeople < ActiveRecord::Migration[5.1]
  def change
    remove_column :people , :type
    add_column :people , :group , :integer
  end
end
