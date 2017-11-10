class UserStepsController < ApplicationController
  include Wicked::Wizard
  steps :sign_up_2, :sign_up_3

  def show
    @user = current_user
    render_wizard
  end
  def update
    @user = current_user
    #@user.attributes = params[:user]
    @user.update_attributes(user_params)
    sign_in(@user, bypass: true) # needed for devise
    case step
      when :sign_up_3
        flash[:notice] = "Signup Successful!"
    end
    render_wizard @user
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :address_1, :address_2, :city, :province, :postal_code,
                                 :country, :home_number, :mobile_number, :age, :profile_pic, :user_id, :group)
  end

end
