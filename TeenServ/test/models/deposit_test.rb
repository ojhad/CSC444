# == Schema Information
#
# Table name: deposits
#
#  id          :integer          not null, primary key
#  paypal      :string
#  address_1   :string
#  address_2   :string
#  city        :string
#  province    :string
#  postal_code :string
#  country     :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  user_id     :integer
#  method      :string           default("check")
#
# Indexes
#
#  index_deposits_on_user_id  (user_id)
#

require 'test_helper'

class DepositTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
