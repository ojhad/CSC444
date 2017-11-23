class PayoutInformationsController < ApplicationController

  def index
    @user = User.find(current_user.id)
    @user_payout_info = @user.payout_information

    if @user_payout_info.no_address?
      @user_payout_info.update(address_1: @user.address_1,address_2:@user.address_2,province: @user.province,
                                city: @user.city, country: @user.country, postal_code: @user.postal_code)
      @user_payout_info.save!
    end

  end

 #update payout method or PayPal address or mailing address

  def update

    @user = User.find(current_user.id)
    @user_payout_info =  @user.payout_information

    @form = params[:which_form]

    if @form=='address'
      @user_payout_info.address_1 = params[:address_1]
      @user_payout_info.address_2 = params[:address_2]
      @user_payout_info.city = params[:city]
      @user_payout_info.country = params[:country]
      @user_payout_info.province = params[:province]
      @user_payout_info.postal_code = params[:postal_code]
      @user_payout_info.method = 'check'
      @user_payout_info.save
      
      flash.notice = "Mailing address updated!"
    elsif @form=='paypal'
      @user_payout_info.paypal = params[:paypal]
      @user_payout_info.method = 'paypal'
      @user_payout_info.save!

      flash.notice = "PayPal address updated!"
    elsif @form=='method'

      @user_payout_info.method = params[:method]

      if @user_payout_info.paypal.blank? && @user_payout_info.method=='paypal'
        @user_payout_info.paypal = @user.email
      end

      @user_payout_info.save!

      flash.notice = "Deposit method updated!"
    else
      flash.alert = "ERROR!"
    end

    redirect_to user_payout_informations_path(@user.id)

  end

end
