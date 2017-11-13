class DepositInformationController < ApplicationController

  def index
    @user = User.find(current_user.id)
    @user_deposit_info = DepositInformation.find_by_user_id(@user.id)

    if @user_deposit_info.no_address?
      @user_deposit_info.update(address_1: @user.address_1,address_2:@user.address_2,province: @user.province,
                                city: @user.city, country: @user.country, postal_code: @user.postal_code)
      @user_deposit_info.save!
    end

  end

  # IF THE CHECK FORM WAS FILLED, THEN TEEN WANTS TO UPDATE MAILING ADDRESS
  # ELSE TEEN PROVIDED NEW PAYPAL ADDRESS

  def update

    @user = User.find(current_user.id)
    @user_deposit_info = DepositInformation.find_by_user_id(@user.id)

    @form = params[:which_form]

    if @form=='address'
      @user_deposit_info.address_1 = params[:address_1]
      @user_deposit_info.address_2 = params[:address_2]
      @user_deposit_info.city = params[:city]
      @user_deposit_info.country = params[:country]
      @user_deposit_info.province = params[:province]
      @user_deposit_info.postal_code = params[:postal_code]
      @user_deposit_info.method = 'check'
      @user_deposit_info.save
      
      flash.notice = "Mailing address updated!"
    elsif @form=='paypal'
      @user_deposit_info.paypal = params[:paypal]
      @user_deposit_info.method = 'paypal'
      @user_deposit_info.save!

      flash.notice = "PayPal Address updated!"
    elsif @form=='method'

      @user_deposit_info.method = params[:deposit]

      if @user_deposit_info.paypal.blank? && @user_deposit_info.method=='paypal'
        @user_deposit_info.paypal = @user.email
      end

      @user_deposit_info.save!

      flash.notice = "Deposit Method updated!"
    else
      flash.alert = "ERROR!"
    end

    redirect_to user_deposit_information_index_path(@user.id)

  end

end
