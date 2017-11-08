class DepositsController < ApplicationController
  def index
    @user = User.find(current_user.id)
  end

  def create

    @user = User.find(current_user.id)

    @user.paypal = params[:paypal]

    @user.save!

    redirect_to users_path(@user.id)

  end

end
