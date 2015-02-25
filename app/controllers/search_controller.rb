class SearchController < ApplicationController

	def search
		if params[:search_query].empty?
			session[:search_query] = nil
		else
			session[:search_query] = params[:search_query]
		end
		redirect_to index_path
	end

	def clear
		session[:search_query] = nil
		redirect_to index_path
	end

	def by_year
		if params[:year] == '0'
			session[:year_filter] = nil
		else
			session[:year_filter] = params[:year]
		end
    	redirect_to index_path
	end	

	def movie_sort
		session[:view_filter] = params[:id]
   		redirect_to index_path
	end

end