class TeensController < ApplicationController
  def new
    @teen = Teen.new
  end
end
