# == Schema Information
#
# Table name: service_users
#
#  id         :integer          not null, primary key
#  user_id    :integer          not null
#  service_id :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_service_users_on_service_id  (service_id)
#  index_service_users_on_user_id     (user_id)
#

require 'test_helper'

class ServiceUserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
