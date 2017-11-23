class Notification < ApplicationRecord
  belongs_to :user
  has_one :reference_user, :class_name => "User", :foreign_key => "reference_user_id"
  has_one :reference_service, :class_name => "Service", :foreign_key => "reference_service_id"

  def self.get_all_user_notifications(user)
    Notification.where(user_id: user.id)
  end

  def self.get_unread_user_notifications(user)
    Notification.where(user_id: user.id, read: false)
  end

  def self.create_notification(user, title, reference_user=nil, reference_service=nil)
    Notification.create(user_id: user.id, title: title, reference_user_id: reference_user.id, reference_service_id: reference_service.id)
  end
end

# == Schema Information
#
# Table name: notifications
#
#  id                   :integer          not null, primary key
#  title                :string
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  read                 :boolean          default(FALSE), not null
#  user_id              :integer
#  reference_user_id    :integer
#  reference_service_id :integer
#
# Indexes
#
#  index_notifications_on_reference_service_id  (reference_service_id)
#  index_notifications_on_reference_user_id     (reference_user_id)
#  index_notifications_on_user_id               (user_id)
#
