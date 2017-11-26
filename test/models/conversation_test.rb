# == Schema Information
#
# Table name: conversations
#
#  id           :integer          not null, primary key
#  sender_id    :integer
#  recipient_id :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
# Indexes
#
#  index_conversations_on_recipient_id  (recipient_id)
#  index_conversations_on_sender_id     (sender_id)
#

require 'test_helper'

class ConversationTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
