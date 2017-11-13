# == Schema Information
#
# Table name: endorsements
#
#  id         :integer          not null, primary key
#  body       :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  author_id  :integer
#  user_id    :integer
#
# Indexes
#
#  index_endorsements_on_user_id  (user_id)
#

require 'test_helper'

class EndorsementTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
