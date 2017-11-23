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

require 'test_helper'

class NotificationTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
