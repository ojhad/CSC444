class HomeController < ApplicationController
  def index
    if current_user
      @user = User.find(current_user.id)
      if @user.is_teen?

        @recommended_services = Service.find_by_sql("SELECT S.ID,S.TITLE,S.CHARGE_PER_HOUR,S.FREQUENCY,S.DESCRIPTION,S.DATE,S.START_TIME,S.END_TIME,S.DAY FROM SERVICES S JOIN
  (SELECT U.SKILL_ID,U.USER_ID,DAY,START_TIME,END_TIME FROM USER_SKILLS U JOIN TEEN_TIMES T ON (U.USER_ID=T.USER_ID AND U.USER_ID=#{@user.id})) A
    ON (S.STATUS=1 AND S.SKILL=A.SKILL_ID AND (#{@user.age} BETWEEN MIN_AGE AND MAX_AGE) AND S.DAY = A.DAY  AND S.START_TIME>=A.START_TIME AND S.END_TIME<=A.END_TIME)")

        @busy_times = Service.find_by_sql("SELECT date, start_time, end_time, day FROM services s JOIN service_users su
        ON s.id = su.service_id AND su.user_id = #{@user.id} AND s.status = 2")

        @recommended_services.each_with_index do |rs, index|
          @busy_times.each do |bt|
            if rs.date.to_date == bt.date.to_date && rs.start_time <= bt.end_time && rs.end_time >= bt.start_time
              @recommended_services.delete_at(index)
              break
            end
          end
        end

        @user_skills = UserSkill.where(user_id: @user.id)
        @user_availability =  TeenTime.where(user_id: @user.id)
        @current_services = @user.service_jobs.where(status: 2);
        @past_services = @user.service_jobs.where(status: 4);
        @same_city_users = User.where('lower(city)= ?', @user.city.downcase).count;
        @jobs_24hrs = Service.where(:created_at=> (Time.now - 24.hours)..Time.now).count;
        @completed_1week = Service.where('created_at >= ?', 1.week.ago.utc).where(status:4).count;

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
