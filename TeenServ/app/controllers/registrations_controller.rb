class RegistrationsController < Devise::RegistrationsController


  def after_sign_up_path_for(resource)
    new_user_path(resource)
  end

  def after_sign_in_path_for(user)
    root_path
  end

end