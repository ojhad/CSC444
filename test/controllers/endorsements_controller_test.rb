# == Schema Information
#
# Table name: endorsements
#
#  id         :integer          not null, primary key
#  body       :text
#  author_id  :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer
#
# Indexes
#
#  index_endorsements_on_user_id  (user_id)
#

require 'test_helper'

class EndorsementsControllerTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
end
