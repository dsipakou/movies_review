class MainController < ApplicationController

	layout "main"
	
  	def index
  		authorize! :index, @movies
  		messages = ["Последние рецензированые/оцененные", 
  					"Последние добавленые", 
  					"Последние комментируемые", 
  					"Самые рецензируемые", 
	  				"Сначала самые охуенные"]
  		if session[:search_query]
  			@movies = Movie.search(session[:search_query])
	  	elsif session[:view_filter]
  			@movies = Movie.sorting_by(session[:view_filter])
			@filter_title = messages[session[:view_filter].to_i() - 1]
	  	else
  			@movies = Movie.sorting_by(1)
			@filter_title = messages[0]
	  	end
  		if params[:clear_filter]
  			session[:search_query] = nil
	  		redirect_to index_path
  		end
  		@years = Movie.get_years()
  	end

  def view_filter
	session[:view_filter] = params[:id]
	redirect_to index_path
  end
end
