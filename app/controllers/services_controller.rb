class ServicesController < ApplicationController

	before_action :find_user

	def index
		@services = Service.status(Service::LISTED).viewable_services(current_user)

    @user = User.find(current_user.id)

    #Store distance of service to the location of the current user
    @services.each do |s|
      distance = s.distance_from(@user, :units=>:kms)
      s.distance = distance
    end

  end

	def show
		@service = Service.find(params[:id])
		@user = User.find(current_user.id)

=begin
		@start_date = @service.date
		@start_day = @start_date.strftime("%A")
		@start_time = @start_date.strftime("%H:%M")

		@end_date = @start_date + @service.duration.hours
		@end_day = @end_date.strftime("%A")
		@end_time = @end_date.strftime("%H:%M")
=end

		# TODO: take into consideration if start and end days are not the same
		# Get all teenagers that match the service's skill. Once service duration is added to the service model, I will update
		# this query to match those with the skill and are available at the given times
		@teens = User.find_by_sql("SELECT * FROM USERS JOIN (SELECT TEEN_TIMES.USER_ID,DAY,START_TIME,END_TIME FROM TEEN_TIMES JOIN
(SELECT USER_SKILLS.USER_ID, SERVICES.MIN_AGE,SERVICES.MAX_AGE FROM SERVICES JOIN USER_SKILLS ON
(SERVICES.SKILL=USER_SKILLS.SKILL_ID AND SERVICES.SKILL=#{@service.skill}))A ON
(A.USER_ID=TEEN_TIMES.USER_ID)) B ON (USERS.ID=B.USER_ID AND B.DAY= '#{@service.day}'
AND B.start_time<='#{@service.start_time}' AND B.END_TIME>='#{@service.end_time}');")

  end

	def new
		@service = Service.new({:user_id => current_user.id,
								:status => Service::UNLISTED})
	end
	def edit
		@service = Service.find(params[:id])
		# When user is editing service, we want to unlist it first
		unlist_service(@service)
	end
	def create
		@service = Service.new(service_params)

    if @service.address_1.blank?
      @user = User.find(current_user.id)
      @service.address_1 = @user.address_1
      @service.address_2 = @user.address_2
      @service.city = @user.city
      @service.country = @user.country
      @service.province = @user.province
      @service.postal_code = @user.postal_code
      @service.save!
    end

		if @service.title != "Other"
			@service.other_title = ""
		end

		# Check to make sure that user is not trying to feed us invalid data
		if @service.status != Service::LISTED && @service.status != Service::UNLISTED
			render :new
		elsif @service.save
			redirect_to(user_path(current_user.id))
		else
			#redirect_back(fallback_location: root_path)
			render :new #(new_user_service_path(@user.id))
		end
	end

	def update
		@service = Service.find(params[:id])

		if params[:service][:title] != "Other"
			params[:service][:other_title] = ""
		end

		if @service.update(service_params)
			redirect_to (user_path(@service.user_id))
		else
			render 'edit'
		end
	end

	def destroy
		@service = Service.find(params[:id])
		user_id = @service.user_id
		@service.destroy
		redirect_to (user_path(user_id))
	end

	# Changes status of the service associated with the passed in service id
	# to LISTED. This makes it visible to other users.
	def list
		@service = Service.find(params[:id])
		@service.update({:status => Service::LISTED});
		redirect_to (@service)
	end

	# Changes status of the service associated with the passed in service id
	# to UNLISTED. This makes it invisible to other users.
	def unlist
		@service = Service.find(params[:id])
		unlist_service(@service)
		redirect_to (@service)
	end

	# User has requested to be considered for this service.
	def add_request
		@service = Service.find(params[:id])

		# Validation booleans to make sure user can be considered for this service
		# A user cannot place a request on a service that they created
		service_is_current_user = @service.user_id == current_user.id;
		# A user cannot place a request on a service that is created by another user of the same group
		service_same_user = @service.user.group == current_user.group;
		#TODO: Add a validation check for Service::LISTED

		if service_is_current_user || service_same_user
			#TODO: Return error if somehow user is trying to request their own service
			puts "ERROR! Unexpected Service Behaviour!"
			redirect_to (services_path)
    else
      @service.user.notifications.create title: "#{current_user.first_name} #{current_user.last_name} has requested you for #{@service.title}!",
                                         reference_user_id: current_user.id,
                                         reference_service_id: @service.id,
                                         user_id: @service.user_id,
                                         read: FALSE
      #@service.user.notifications.create_notification(@service.user,
       # "#{current_user.first_name} #{current_user.last_name} has requested you for #{@service.title}!",
        #current_user, @service)
			@service.service_users.create service_id: @service.id, user_id: current_user.id
			redirect_to (services_path)
		end
	end

	# User wants their request for this service to me removed
	def remove_request
		@service = Service.find(params[:id])

		# Make sure request exists before removing request
		if @service.service_users.exists?(:user_id => current_user.id) 
			delete_record = @service.service_users.where(user_id: current_user.id)
			if delete_record
				delete_record_id = delete_record[0].id
				@service.service_users.destroy(delete_record_id)
			end
			redirect_to (services_path)
		else
			# Do nothing because user is trying to remove themselves from 
			# a service which they are not requested for
			puts "TRYING TO DELETE A NON-EXISTENT RELATION"
			redirect_to (services_path)
		end
	end

	# User has accepted a specific request
	def select_request
		@service = Service.find(params[:id])
		sel_user_id = params[:userId]

		# logic validation checks
		serv_user_is_current_user = @service.user_id == current_user.id;
		sel_user_is_in_serv_req = @service.service_users.exists?(:user_id => sel_user_id)
		serv_is_listed = @service.status == Service::LISTED

		if serv_user_is_current_user && sel_user_is_in_serv_req && serv_is_listed
			# delete all the other requests
			@service.service_users.each do |relation|
				if relation.user_id != sel_user_id.to_i
					@service.service_users.destroy(relation)
				end
			end
			@service.update({:status => Service::ACCEPTED});
		end
		redirect_to (@service)
	end

	# PRIVATE METHODS BEGIN HERE
	private 

	def service_params
   		params.require(:service).permit(:user_id,:main_title,:title,:other_title,:charge_per_hour,:user_type,:frequency,
   										:min_age,:max_age,:status,:description,:skill,:date,:day,:duration,:start_time,:end_time,:address_1,
											:address_2,:city,:province,:country,:postal_code)
	end

	def find_user
		if params[:user_id]
			@user = User.find(params[:user_id])
		end
	end

	def unlist_service(service)
		if @service.status == Service::LISTED || @service.status == Service::ACCEPTED
			@service.service_users.destroy_all
			@service.update({:status => Service::UNLISTED});
			return true
		else
			#return an error because user cannot unlist completed services
			puts "ERROR! Cannot change status of COMPLETED services!"
			return false
		end
	end

end
