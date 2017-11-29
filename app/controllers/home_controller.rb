class HomeController < ApplicationController
  def index
    if current_user
      @user = User.find(current_user.id)
      if @user.is_teen?

        @recommended_services = Service.find_by_sql("SELECT S.ID,S.TITLE,S.CHARGE_PER_HOUR,S.FREQUENCY,S.DESCRIPTION FROM SERVICES S JOIN
  (SELECT U.SKILL_ID,U.USER_ID,DAY,START_TIME,END_TIME FROM USER_SKILLS U JOIN TEEN_TIMES T ON (U.USER_ID=T.USER_ID AND U.USER_ID=#{@user.id})) A
    ON (S.STATUS=1 AND S.SKILL=A.SKILL_ID AND (#{@user.age} BETWEEN MIN_AGE AND MAX_AGE) AND S.DAY = A.DAY  AND S.START_TIME>=A.START_TIME AND S.END_TIME<=A.END_TIME)")

        @user_skills = UserSkill.where(user_id: @user.id)
        @user_availability =  TeenTime.where(user_id: @user.id)
      elsif @user.is_client?
        @latest_service = Service.where(user_id: @user.id).order('created_at DESC').limit(1)
        @current_services = Service.where(user_id: @user.id , status:2)
        @pending_services = Service.where(user_id: @user.id, status: 3)
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
