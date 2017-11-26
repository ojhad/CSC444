class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :set_locale
  impersonates :user
  before_action :get_notifications
  def get_notifications
    if current_user
        @notifications = Notification.get_unread_user_notifications( current_user)
    end
  end

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end
end
