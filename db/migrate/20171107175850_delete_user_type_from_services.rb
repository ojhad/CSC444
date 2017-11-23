class DeleteUserTypeFromServices < ActiveRecord::Migration[5.1]
  def change
  	remove_column :services, :user_type
  end
end
