class MainController < ApplicationController

	layout "main"

  def index
  	authorize! :index, @movies
  	@movies = Movie.order("updated_at DESC");
  end
end
