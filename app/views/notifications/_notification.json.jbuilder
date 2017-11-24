json.extract! notification, :id, :title, :reference_user_id, :reference_service_id, :user_id, :read, :created_at, :updated_at
json.url notification_url(notification, format: :json)
