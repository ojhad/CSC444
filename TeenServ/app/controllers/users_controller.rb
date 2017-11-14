class UsersController < ApplicationController
	def show
		@user = User.find(params[:id])
		@current_user = current_user
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

	def new

	end

	def add_user
		User.create(email: params[:user][:email], password: params[:user][:password], password_confirmation: params[:user][:password_confirmation], group: params[:group])
	end
end
