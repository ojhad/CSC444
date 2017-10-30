class ServicesController < ApplicationController

	before_action :find_user

	def index
		@services = Service.all()
	end

	def show
		@service = Service.find(params[:id])
	end

	def new
		puts "CREATING SERVICE FOR: #{current_user.email}"
		@service = Service.new({:user_id => current_user.id, 
								:status => Service::UNLISTED})
	end
	def edit
		@service = Service.find(params[:id])
		# When user is editing service, we want to remove it from public visibility
		@service.update({:status => Service::UNLISTED});
	end
	def create
		@service = Service.new(service_params)
		if @service.save
			redirect_to(user_path(current_user.id))
		else
			render :new #(new_user_service_path(@user.id))
		end
	end

	def update
		@service = Service.find(params[:id])
		if(@service.update(service_params))
			redirect_to (user_path(@service.user_id))
		else
			render 'edit'
		end
	end

	def destroy
		@service = Service.find(params[:id])
		userId = @service.user_id
		@service.destroy
		redirect_to (user_path(userId))
	end

	private 

	def service_params
   		params.require(:service).permit(:user_id,:title,:charge_per_hour,:user_type,:frequency, 
   										:min_age,:max_age).merge(status: Service::UNLISTED)
	end

	def find_user
		if params[:user_id]
			@user = User.find(params[:user_id])
		end
	end

	# Changes status of the service associated with the passed in 'serviceId'
	# to LISTED. This makes it visible to other users.
	def listService(serviceId)
		@service = Service.find(serviceId)
		@service.update({:status => Service::LISTED});
	end

	# Changes status of the service associated with the passed in 'serviceId'
	# to UNLISTED. This makes it invisible to other users.
	def unlistService(serviceId)
		@service = Service.find(serviceId)
		if(@service.status == Service::LISTED || @service.status == Service::ACCEPTED)
			@service.update({:status => Service::UNLISTED});
		else
			#return an error because user cannot unlist completed services
			return "ERROR! Cannot change status of COMPLETED services!"
		end
	end

	# User has requeseted to be considered for this service.
	def requestService
		puts "Calling request service controller method"
		#requesting_user = User.find(userId)
		#@service.services_users.create service: @service user: requesting_user
	end


end
