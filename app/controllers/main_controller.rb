class MainController < ApplicationController

	layout "main"

  def index
  	authorize! :index, @movies
  	@movies = Movie.all;
  end
end
