# == Schema Information
#
# Table name: payouts
#
#  id         :integer          not null, primary key
#  amount     :float
#  batch_id   :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  method     :string
#

require 'test_helper'

class PayoutTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
