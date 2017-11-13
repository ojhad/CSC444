class EndorsementRequest < ApplicationRecord
  belongs_to :user, :class_name => 'User'
  belongs_to :invitee, :class_name => 'User'
end

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
