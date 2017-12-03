class Conversation < ApplicationRecord
  belongs_to :sender, :class_name => 'User'
  belongs_to :recipient, :class_name => 'User'

  has_many :messages, dependent: :destroy

  validates_uniqueness_of :sender_id, :scope => :recipient_id

  def self.my_unread_messages_count (user_id)
    conversations = Conversation.user_conversations(user_id)
    unread_count = 0
    conversations.each do |conversation|
      user_to_find = conversation.sender_id == user_id ? conversation.recipient_id : conversation.sender_id
      unread_count += conversation.messages.unread_by_me(user_to_find).count
    end
    return unread_count
  end

  scope :between, -> (sender_id, recipient_id) do
    where("(conversations.sender_id = #{sender_id} AND conversations.recipient_id = #{recipient_id})
      OR (conversations.sender_id = #{recipient_id} AND conversations.recipient_id = #{sender_id})")
  end

  scope :user_conversations, -> (user_id) do
    where("conversations.sender_id = #{user_id} OR conversations.recipient_id = #{user_id}")
  end
end

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
