class AddMainTitleToServices < ActiveRecord::Migration[5.1]
  def change
    add_column :services, :main_title, :string
  end
end
