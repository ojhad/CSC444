class ChangeTypeOfTypeInPeople < ActiveRecord::Migration[5.1]
  def change
    change_column :people , :type , :integer, using: 'type::integer'
  end
end
