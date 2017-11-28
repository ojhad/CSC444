class Message < ApplicationRecord
  belongs_to :conversation
  belongs_to :user

  validates_presence_of :body, :conversation_id, :user_id

  def message_time
    created_at.strftime("%m/%d/%y at %l:%M %p")
  end

  def self.mark_messages_as_read (messages)
    messages.each do |message|
      message.read = true
      message.save
    end
  end
  scope :unread, -> () do
    where("messages.read = #{false}")
  end
end

# == Schema Information
#
# Table name: messages
#
#  id              :integer          not null, primary key
#  body            :string
#  read            :boolean          default(FALSE)
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
