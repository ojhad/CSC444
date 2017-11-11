class TeenTimesController < ApplicationController
  before_action :find_user

  def edit

  end

  def create
    @teenTime = TeenTime.new(user_id: @user, day: params[:day], start_time: param[:start_time], end_time: param[:end_time])
    @teenTime.save
  end

  def destroy

  end

  def find_user
    if params[:user_id]
      @user = User.find(curren_user.id)
    end
  end

end
