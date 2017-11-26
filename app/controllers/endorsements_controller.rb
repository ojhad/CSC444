class EndorsementsController < ApplicationController
before_action :find_user

  def index
  end

  def new
  end

  def create
    @endorsement = Endorsement.new(endorsements_params)
    if @endorsement.save
      @user.notifications.create title: "#{current_user.first_name} #{current_user.last_name} has endorsed you!",
                                   reference_user_id: current_user.id,
                                   user_id: @user,
                                   read: FALSE
      redirect_to(user_path(@user.id))
    else
      render :new
    end
  end
  private

  def find_user
    if params[:user_id]
      @user = User.find(params[:user_id])
    end
  end

  def endorsements_params
    params.require(:endorsement).permit( :body, :user_id, :author_id)
  end

end
