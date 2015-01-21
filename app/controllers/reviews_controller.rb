class ReviewsController < ApplicationController

	before_action :set_review, only: [:show, :edit, :update, :destroy]


	def index
		
	end

	def show
		@user_name = User.find(@review.user_id).nickname
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
