class MainController < ApplicationController

	layout "main"

  def index
  	@movies = Movie.all;
  	#authorize! :index, @movies
  end
end
