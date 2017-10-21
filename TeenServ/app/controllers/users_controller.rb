class UsersController < ApplicationController

	def new
		@user = User.find(params[:format])
	end

	def show
		@user = User.find(params[:id])
	end


	def edit
		@user = User.find(params[:id])
		@user.update_attributes(user_params)
		redirect_to @user
	end

	private
	def user_params
	params.require(:user).permit(:first_name, :address_1, :address_2, :city, :province, :postal_code,
	                               :country, :home_number, :mobile_number, :age, :profile_pic, :user_id, :group)
	end
end
