class TeenTimesController < ApplicationController
  before_action :find_user

  def edit
    @teenTime = TeenTime.find_by_sql("SELECT * FROM teen_times WHERE user_id = #{@user.id}")
    @teenDays = TeenTime.find_by_sql("SELECT day FROM teen_times WHERE user_id = #{@user.id}  ORDER BY
     CASE
          WHEN day = 'Monday' THEN 1
          WHEN day = 'Tuesday' THEN 2
          WHEN day = 'Wednesday' THEN 3
          WHEN day = 'Thursday' THEN 4
          WHEN day = 'Friday' THEN 5
          WHEN day = 'Saturday' THEN 6
					WHEN day = 'Sunday' THEN 7
     END ASC").uniq{|time| time.day }
  end

  def create
    @teenTime = TeenTime.new(user_id: @user.id, day: params[:day], start_time: params[:start_time], end_time: params[:end_time])
    @teenTime.save
  end

  def destroy
    if params[:start_time]
      TeenTime.where(:user_id => @user.id).where(:day => params[:day]).where(:start_time => Time.parse(params[:start_time]).strftime("%H:%M")).where(:end_time => Time.parse(params[:end_time]).strftime("%H:%M")).destroy_all
    else
      TeenTime.where(:user_id => @user.id).where(:day => params[:day]).destroy_all
    end
  end

  def removeDay
    TeenTime.where(:user_id => @user.id).where(:day => params[:day]).destroy_all
  end

  def find_user
      @user = User.find(current_user.id)
  end

end
