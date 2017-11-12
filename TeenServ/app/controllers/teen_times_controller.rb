class TeenTimesController < ApplicationController
  before_action :find_user

  def edit

  end

  def create
    @teenTime = TeenTime.new(user_id: @user.id, day: params[:day], start_time: params[:start_time], end_time: params[:end_time])
    @teenTime.save
  end

  def destroy

  end

  def find_user
      @user = User.find(current_user.id)
  end

end
