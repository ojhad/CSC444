class ChangeViewedToReadInNotifications < ActiveRecord::Migration[5.1]
  def change
    rename_column :notifications, :viewed, :read
  end
end
