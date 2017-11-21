class HomeController < ApplicationController
  def index
    if current_user
      @user = User.find(current_user.id)
      if @user.is_teen?
        @recommended_services = Service.find_by_sql("SELECT SERVICES.ID,SERVICES.TITLE,SERVICES.CHARGE_PER_HOUR,SERVICES.FREQUENCY,SERVICES.DESCRIPTION
FROM SERVICES JOIN USER_SKILLS ON (SERVICES.SKILL=USER_SKILLS.SKILL_ID AND USER_SKILLS.USER_ID=#{@user.id} AND SERVICES.STATUS=1);")
      end
    else
      @user = nil
    end
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
