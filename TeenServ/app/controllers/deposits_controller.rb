class DepositsController < ApplicationController

  def index
    @user = User.find(current_user.id)
    @user_deposit_info = Deposit.find_by_user_id(@user.id)

    # EACH USER SHOULD HAVE AN ENTRY IN DEPOSITS TABLE, SO IF ITS THE FIRST TIME FOR THE USER TO VISIT THIS PAGE
    # CREATE AN ENTRY FOR HIM/HER IN THE TABLE AND PRE-POPULATE THE TABLE WITH THEIR PROVIDED ADDRESS
    if @user_deposit_info.blank?
      @new_entry = Deposit.new(:address_1=>@user.address_1,:address_2=>@user.address_2,:city=>@user.city,
      :country=>@user.country,:postal_code=>@user.postal_code,:province=>@user.province,:user_id=>@user.id)
      @new_entry.save
      @user_deposit_info = @new_entry
    end

  end

  # IF THE CHECK FORM WAS FILLED, THEN TEEN WANTS TO UPDATE MAILING ADDRESS
  # ELSE TEEN PROVIDED NEW PAYPAL ADDRESS
  # TODO: CREATE A DB COLUMN IN DEPOSITS TABLE TO INDICATE WHICH DEPOSIT METHOD THEY CHOSE. REFLECT THIS ON FRONT-END

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
