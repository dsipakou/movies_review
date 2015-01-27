class ReviewsController < ApplicationController

	before_action :set_review, only: [:show, :edit, :update, :destroy]

	def index
		authorize! :index, @review

	end

	def show
		authorize! :show, @review
		@user_name = User.find(@review.user_id).nickname
	end

	def update
		params_to_update = {}
		if params[:awesome] 
			params_to_update = { awesome: params[:awesome] }
		elsif params[:stars]
			params_to_update = { stars: params[:awesome] }
		else
			params_to_update = review_params
		end
		if @review.update(params_to_update)
			respond_to do |format|
        		format.js { }
				format.html { redirect_to @review.movie }
      		end
    	end
	end

	def create
		@review = Review.new(review_params)

		respond_to do |format|
			if @review.save
				format.html { redirect_to @review.movie, notice: "Thanks"}
			end
		end
	end

	def destroy
		@review.destroy
		respond_to do |format|
			format.html { redirect_to @review.movie, notice: "Deleted" } 
			format.js
		end
	end

	private

		def set_review
			@review = Review.find(params[:id])
		end

		def review_params
			params.require(:review).permit(:movie_id, :user_id, :content, :stars, :awesome)
		end
end
