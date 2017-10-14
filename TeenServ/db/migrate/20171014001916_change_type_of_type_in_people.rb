class ChangeTypeOfTypeInPeople < ActiveRecord::Migration[5.1]
  def change
    change_column :people , :type , :integer
  end
end
