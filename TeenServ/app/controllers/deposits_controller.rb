class DepositsController < ApplicationController
  def index
    @user = User.find(current_user.id)
    @user_deposit_info = Deposit.find_by_user_id(@user.id)

    if @user_deposit_info.blank?
      @new_entry = Deposit.new(:address_1=>@user.address_1,:address_2=>@user.address_2,:city=>@user.city,
      :country=>@user.country,:postal_code=>@user.postal_code,:province=>@user.province,:user_id=>@user.id)
      @new_entry.save
      @user_deposit_info = @new_entry
    end

  end

  def create

    @user = User.find(current_user.id)

    @user.paypal = params[:paypal]

    @user.save!

    redirect_to users_path(@user.id)

  end

end
