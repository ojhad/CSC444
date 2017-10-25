class RegistrationsController < Devise::RegistrationsController


  def after_sign_up_path_for(resource)
    root_path
  end

  def after_sign_in_path_for(user)
    root_path
  end

  private

  def sign_up_params
  	params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :address_1, :address_2, :city, :province, :postal_code,
	                               :country, :home_number, :mobile_number, :age, :profile_pic, :user_id, :group)
  end

  def account_update_params
  	params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :current_password, :address_1, :address_2, :city, :province, :postal_code,
	                               :country, :home_number, :mobile_number, :age, :profile_pic, :user_id, :group)
  end

end