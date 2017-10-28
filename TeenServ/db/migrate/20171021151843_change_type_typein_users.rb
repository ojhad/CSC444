class ChangeTypeTypeinUsers < ActiveRecord::Migration[5.1]
  def change
    remove_column :users , :type
    add_column :users , :group , :integer
  end
end
