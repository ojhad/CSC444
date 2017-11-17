class AddOtherAndDescriptionToService < ActiveRecord::Migration[5.1]
  def change
      add_column :services, :other_title, :string
      add_column :services, :description, :string
  end
end
