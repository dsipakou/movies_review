class MainController < ApplicationController

  layout "main"
	
  def index
  	authorize! :index, @movies
    @search_params = {}
  	messages = ["Последние рецензированые/оцененные", 
  				"Последние добавленые", 
  				"Последние комментируемые", 
  				"Самые рецензируемые", 
	 				"Сначала самые охуенные"]
  	@years = Movie.get_years()

    unless session[:search_query].nil?
      @search_params[:search_query] = session[:search_query]
    end

    unless session[:view_filter].nil?
      @search_params[:view_filter] = session[:view_filter]
      @filter_title = messages[session[:view_filter].to_i() - 1]
    else
      @search_params[:view_filter] = 1
      @filter_title = messages[0]
    end

    unless session[:year_filter].nil?
      @search_params[:year_filter] = session[:year_filter]
      @year_filter_title = session[:year_filter]
    else
      @year_filter_title = "Все года"
    end
      
    @movies = Movie.filter(@search_params)
  end
end
