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
    @user_deposit_info = Deposit.find_by_user_id(@user.id)

    @form = params[:which_form]

    if @form=='address'
      @user_deposit_info.address_1 = params[:address_1]
      @user_deposit_info.address_2 = params[:address_2]
      @user_deposit_info.city = params[:city]
      @user_deposit_info.country = params[:country]
      @user_deposit_info.province = params[:province]
      @user_deposit_info.postal_code = params[:postal_code]
      @user_deposit_info.save
      
      flash.notice = "Mailing address updated!"
    elsif @form=='paypal'
      @user_deposit_info.paypal = params[:paypal]

      @user_deposit_info.save!

      flash.notice = "PayPal Address updated!"
    else
      flash.alert = "ERROR!"
    end

    redirect_to user_deposits_path(@user.id)

  end

end
