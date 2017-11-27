require 'test_helper'

class ServiceTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end

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
#  skill           :integer
#  duration        :decimal(, )
#  date            :time
#  start_time      :time
#  end_time        :time
#  day             :string
#  address_1       :string
#  address_2       :string
#  city            :string
#  province        :string
#  postal_code     :string
#  country         :string
#  latitude        :float
#  longitude       :float
#  main_title      :string
#
# Indexes
#
#  index_services_on_user_id  (user_id)
#
