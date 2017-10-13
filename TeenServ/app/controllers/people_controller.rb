class PeopleController < ApplicationController

  def new
    @person = Person.new
  end

  def show
    @person = Person.find(params[:id])
  end

end
