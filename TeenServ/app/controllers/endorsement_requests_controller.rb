class EndorsementRequestsController < ApplicationController
  before_action :find_user

  def index
  end

  def new
  end

  def create
    request_params = endorsement_request_params.merge!(:user_id => @user.id)
    invitee = User.find_by_id(request_params[:invitee_id])
    if invitee.blank?
      flash[:alert] = 'Error sending endorsement invite: user not found'
      redirect_to(user_path(@user.id))
    else
      @request = EndorsementRequest.new(request_params)
      if @request.save
        redirect_to(user_path(@user.id))
        flash[:notice] = 'Sent Invite'
      else
        flash[:alert] = 'Error sending endorsement invite: error saving'
        redirect_to(user_path(@user.id))
      end
    end
  end

  private

  def find_user
    if params[:user_id]
      @user = User.find(params[:user_id])
    end
  end

  def endorsement_request_params
    params.require(:endorsement_request).permit( :user_id, :invitee_id)
  end

end
