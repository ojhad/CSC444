class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  impersonates :user
  before_action :get_notifications
  def get_notifications
    if current_user
        @notifications = Notification.get_unread_user_notifications(current_user)
    end
  end
end
