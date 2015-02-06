class PostsController < ApplicationController
	layout "posts"
	before_filter :modify_content, :only => [:create, :update]

	before_action :set_post, only: [:show, :edit, :update, :destroy]

	def index
		authorize! :index, @posts
		@posts = Post.order("created_at DESC")
	end

	def new
    	authorize! :new, @post
    	@post = Post.new
  	end

  	def create
    @post = Post.new(post_params)
    respond_to do |format|
      if @post.save
        format.html { redirect_to posts_path, notice: 'Post was successfully created.' }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

	private
		def set_post
			@post = Post.find(params[:id])
		end

		def post_params
      		params.require(:post).permit(:user_id, :content)
    	end

    	def modify_content
		      params[:post][:content] = params[:post][:content].gsub(/(\r)?\n/, '<br />').gsub('<img', '<br /><img').gsub('/img>', '/img><br />') unless params[:post][:content].nil?
	    end
end