class SearchController < ApplicationController

	def search
		if params[:search_query].empty?
			session[:search_query] = nil
		else
			session[:search_query] = params[:search_query]
		end
		redirect_to index_path
	end

end