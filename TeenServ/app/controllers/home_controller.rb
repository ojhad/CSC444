class HomeController < ApplicationController
  def index
  end

  def about
  end

  def terms_of_service
  end

  def faq
  end

  def contact_us
  end

  def send_email
    ContactUsMailer.contact_us_mail(params[:request_anonymous_requester_email], params[:request_description]).deliver
    redirect_to root_path
  end
end
