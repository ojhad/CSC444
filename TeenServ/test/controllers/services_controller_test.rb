# == Schema Information
#
# Table name: services
#
#  id              :integer          not null, primary key
#  user_id         :integer
#  title           :string
#  charge_per_hour :float
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  status          :integer
#  frequency       :integer
#  min_age         :integer
#  max_age         :integer
#  other_title     :string
#  description     :string
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
