class MainController < ApplicationController

	layout "main"

  def index
  	authorize! :index, @movies
  	if session[:search_query]
  		@movies = Movie.where("title LIKE ? OR orig_title LIKE ?", "%#{session[:search_query]}%", "%#{session[:search_query]}%")
  	elsif session[:view_filter]
  		case session[:view_filter]
			when "1"
				@movies = Movie.order("created_at DESC").first(20)
				@filter_title = "Последние добавленые"
			when "2"
				@movies = Movie.joins(:reviews).where("reviews.content <> '' OR reviews.stars <> '' OR reviews.awesome <> ''").order('reviews.updated_at DESC').first(100000).uniq().first(20)
				@filter_title = "Последние рецензированые/оцененные"	
			when "3"
				@movies = Movie.joins(:comments).order('comments.updated_at DESC').first(100000).uniq().first(20)
				@filter_title = "Последние комментируемые"
			when "4"
				@movies = Movie.joins(:reviews).where.not(reviews: {content: nil}).group("reviews.movie_id").order("count(reviews.movie_id) DESC").first(20)
				@filter_title = "Самые рецензируемые"
			when "5"
				@movies = Movie.joins(:reviews).where(reviews: {awesome: 1}).group("reviews.movie_id").order("count(reviews.movie_id) DESC").first(20)
				@filter_title = "Сначала самые охуенные"
			else
				@movies = Movie.order("created_at DESC").first(20)
				@filter_title = "Последние добавленые"
			end
  	else
  		@movies = Movie.order("updated_at DESC").first(20);
  		@filter_title = "Последние добавленые"
  	end
  	if params[:clear_filter]
  		session[:search_query] = nil
  		redirect_to index_path
  	end
  end

  def view_filter
	session[:view_filter] = params[:id]
	redirect_to index_path
  end
end
