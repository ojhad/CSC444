class HomeController < ApplicationController
  def index
    if current_user
      @user = User.find(current_user.id)
      if @user.is_teen?

        @recommended_services = Service.find_by_sql("SELECT SERVICES.ID,SERVICES.TITLE,SERVICES.CHARGE_PER_HOUR,SERVICES.FREQUENCY,SERVICES.DESCRIPTION
FROM SERVICES JOIN USER_SKILLS ON (SERVICES.SKILL=USER_SKILLS.SKILL_ID AND USER_SKILLS.USER_ID=#{@user.id} AND SERVICES.STATUS=1);")

=begin
        select S.ID,S.TITLE,S.CHARGE_PER_HOUR,S.FREQUENCY,S.DESCRIPTION from services S join
        (SELECT U.SKILL_ID,U.USER_ID,DAY,START_TIME,END_TIME FROM USER_SKILLS U JOIN TEEN_TIMES T ON (U.USER_ID=T.USER_ID AND U.USER_ID=1)) A
        on (S.STATUS=1 AND S.SKILL=A.SKILL_ID AND 13>=MIN_AGE AND 13<=MAX_AGE)
=end
        @user_skills = UserSkill.where(user_id: @user.id)
        @user_availability =  TeenTime.where(user_id: @user.id)
      elsif @user.is_client?
        @latest_service = Service.where(user_id: @user.id).order('created_at DESC').limit(1)
        @current_services = Service.where(user_id: @user.id , status:2)
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
