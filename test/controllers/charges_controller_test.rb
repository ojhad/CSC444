# == Schema Information
#
# Table name: charges
#
#  id               :integer          not null, primary key
#  stripe_charge_id :string
#  amount           :float
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  user_id          :integer
#
# Indexes
#
#  index_charges_on_user_id  (user_id)
#

require 'test_helper'

class ChargesControllerTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
end
