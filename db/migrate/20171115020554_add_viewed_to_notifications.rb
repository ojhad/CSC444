class AddViewedToNotifications < ActiveRecord::Migration[5.1]
  def change
    add_column :notifications, :viewed, :boolean, null: false, default: false
  end
end
