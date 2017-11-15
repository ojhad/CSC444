class AddUserToNotification < ActiveRecord::Migration[5.1]
  def change
    add_reference :notifications, :user, foreign_key: true
  end
end
