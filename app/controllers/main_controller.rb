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
    if params[:clear_filter].present?
      session[:search_query] = nil
      redirect_to index_path
    end
    if session[:search_query]
      @search_params[:search_query] = session[:search_query]
    end
    if session[:view_filter]
      @search_params[:view_filter] = session[:view_filter]
      @filter_title = messages[session[:view_filter].to_i() - 1]
    else
      @search_params[:view_filter] = 1
      @filter_title = messages[0]
    end
    if session[:year_filter]
      year = session[:year_filter]
      if year == '0'
        session[:year_filter] = nil
        @year_filter_title = "Все года"
      else
        @search_params[:year_filter] = session[:year_filter]
        @year_filter_title = year
      end
    else
      @year_filter_title = "Все года"
    end
      
    @movies = Movie.filter(@search_params)
  end

  def view_filter
	 session[:view_filter] = params[:id]
	 redirect_to index_path
  end

  def year_filter
    session[:year_filter] = params[:year]
    redirect_to index_path
  end
end
