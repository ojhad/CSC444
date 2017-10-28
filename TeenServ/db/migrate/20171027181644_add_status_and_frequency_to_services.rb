class AddStatusAndFrequencyToServices < ActiveRecord::Migration[5.1]
  def change
    rename_column :services, :service_title, :title
    add_column :services , :status , :integer
    add_column :services , :frequency , :integer
  end
end
