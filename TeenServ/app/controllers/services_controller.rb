class ServicesController < ApplicationController

	before_action :find_user

	def new
		puts @user
		 @service = Service.new({:user_id => current_user.id})
	end
	def create
		@service = Service.new(service_params)
		if @service.save
			redirect_to(user_path(current_user.id))
		else
			render :new #(new_user_service_path(@user.id))
		end
	end

	private 

	def service_params
   		params.require(:service).permit(:user_id,:service_title,:charge_per_hour,:user_type)
	end

	def find_user
		if params[:user_id]
			@user = User.find(params[:user_id])
		end
	end

	def show

	end

end
