module MainHelper
	DATED_QUERY = "created_at > ? and content is not null"
	def get_all_responses_amount(movie, type)
		@size = if type == "review"
			movie.reviews.where.not(content: nil).size
		elsif type == "comment"
			movie.comments.where.not(content: nil).size
		end
	end

	def get_new_responses_amount(movie, type)
		@get_last_view = TrackTimes.get_last_view(movie.id, session[:userid])
		@time = unless @get_last_view.size == 0
			case type
			when "comment"
				@get_last_view.first.comment_view_time.nil? ? 0 : @get_last_view.first.comment_view_time
			when "review"
				@get_last_view.first.review_view_time.nil? ? 0 : @get_last_view.first.review_view_time
			else
				0
			end
		else
			0
		end
		@size = if type == "review"
			movie.reviews.where([DATED_QUERY, @time]).where.not(content: nil).size
		elsif type == "comment"
			movie.comments.where([DATED_QUERY, @time]).where.not(content: nil).size
		end
		@size > 0 ? "<strong>новых #{@size}</strong>" : "новых нет"
	end
end
