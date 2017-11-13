# == Schema Information
#
# Table name: endorsement_requests
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  invitee_id :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_endorsement_requests_on_invitee_id  (invitee_id)
#  index_endorsement_requests_on_user_id     (user_id)
#

require 'test_helper'

class EndorsementRequestTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
