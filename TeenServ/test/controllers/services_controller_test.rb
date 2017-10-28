# == Schema Information
#
# Table name: services
#
#  id              :integer          not null, primary key
#  user_id         :integer
#  title           :string
#  charge_per_hour :float
#  user_type       :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  status          :integer
#  frequency       :integer
#
# Indexes
#
#  index_services_on_user_id  (user_id)
#

require 'test_helper'

class ServicesControllerTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
end
