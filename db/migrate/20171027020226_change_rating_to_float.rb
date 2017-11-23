class ChangeRatingToFloat < ActiveRecord::Migration[5.1]
  def change
    remove_column :reviews, :rating, :integer
    add_column :reviews, :rating, :float, :default => 5.0
  end
end
