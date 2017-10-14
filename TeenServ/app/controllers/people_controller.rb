class PeopleController < ApplicationController

  def new
    @person = Person.new
  end

  def show
    @person = Person.find(params[:id])
  end

  def create
    @person = Person.new(person_params)
    @person.user_id = current_user.id
    @person.email = current_user.email
    @person.save
    redirect_to @person
  end

  private
  def person_params
    params.require(:person).permit(:first_name, :last_name, :address_1, :address_2, :city, :province, :postal_code,
                                   :country, :home_number, :mobile_number, :age, :profile_pic, :group, :user_id)
  end

end
