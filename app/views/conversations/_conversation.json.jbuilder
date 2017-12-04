json.extract! conversation,  :sender_id, :created_at
json.url conversation_url(conversation, format: :json)
