class SearchController < ApplicationController
  def search
    @services = Service.search(params[:search_term])
  end
end
