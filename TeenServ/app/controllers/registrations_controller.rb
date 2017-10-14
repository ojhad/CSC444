class RegistrationsController < Devise::RegistrationsController
  def after_sign_up_path_for(resource)
    new_person_path(resource)
  end
end