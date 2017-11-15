json.extract! notification, :id, :title, :created_at, :updated_at
json.url notification_url(notification, format: :json)
