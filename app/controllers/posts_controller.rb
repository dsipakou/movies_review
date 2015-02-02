class PostsController < ApplicationController
	layout "posts"

	def index
		authorize! :index, @posts
	end
end