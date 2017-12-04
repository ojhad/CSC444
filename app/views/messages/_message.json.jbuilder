json.extract! message, :id, :body, :read, :conversation_id, :user_id, :created_at, :updated_at
json.extract! message.user,  :first_name, :last_name, :profile_pic
json.url message_url(message, format: :json)
