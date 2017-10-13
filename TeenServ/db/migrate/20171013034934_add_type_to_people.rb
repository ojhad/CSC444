class AddTypeToPeople < ActiveRecord::Migration[5.1]
  def change
    add_column :people, :type, :string
  end
end
