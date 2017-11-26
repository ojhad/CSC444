class UsersController < ApplicationController
	def show
		@user = User.find(params[:id])
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
		User.create(add_user_params)
		redirect_to home_index_path
	end

	def add_user_params
		params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :address_1, :address_2, :city, :province, :postal_code,
																 :country, :home_number, :mobile_number, :age, :profile_pic, :user_id, :group)
  end

  def login_as
    @users = User.all
	end

	def sql_interface(result = nil)

    
	end

	def run_query
		@result = ActiveRecord::Base.connection.exec_query(params[:query])
		x = "<tr>"
		@result.columns.each do |col|
			x << "<th> #{col} </th>"
		end
		x << "</tr>"
		@result.each do |row|
			x << "<tr>"
			row.each do |val|
				x << "<th>#{val[1]}</th>"
			end
			x << "</tr>"
		end
		respond_to do |format|
			msg = { :status => "ok", :message => "Success!", :html => x}
			format.json  { render :json => msg } # don't do msg.to_json
		end
	end

	def impersonate
	  user = User.find(params[:id])
		impersonate_user(user)
		redirect_to root_path
	end

	def stop_impersonating
		stop_impersonating_user
		redirect_to root_path
	end
end
