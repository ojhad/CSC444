class AddUserAndServiceReferenceToNotification < ActiveRecord::Migration[5.1]
  def change
    add_reference :notifications, :reference_user, foreign_key: { to_table: :users }
    add_reference :notifications, :reference_service, foreign_key: { to_table: :services }
  end
end
