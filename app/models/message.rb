class Message < ApplicationRecord
  belongs_to :conversation
  belongs_to :user
end

# == Schema Information
#
# Table name: messages
#
#  id              :integer          not null, primary key
#  body            :string
#  read            :boolean
#  conversation_id :integer
#  user_id         :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  index_messages_on_conversation_id  (conversation_id)
#  index_messages_on_user_id          (user_id)
#
