class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def after_sign_in_path_for(user)

    person = Person.find_by(user_id: current_user.id).id

    person_path(person)

  end

end
