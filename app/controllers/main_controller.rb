class MainController < ApplicationController

  def index
  	@movies = Movie.all;
  	#authorize! :index, @movies
  end
end
