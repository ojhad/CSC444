class AddAverageRatingToUsersTable < ActiveRecord::Migration[5.1]
  def change
    add_column :users , :average_rating , :float
  end
end
