class AddNotificationTypeToNotification < ActiveRecord::Migration[5.1]
  def change
    add_column :notifications, :notification_type, :string
  end
end
