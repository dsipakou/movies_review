module PostsHelper
	DATED_QUERY = "created_at > ? and content is not null"
	def get_all_post_comments_amount(post)
		@size = post.post_comments.where.not(content: nil).size
	end

	def get_new_post_comments_amount(post)
		@get_last_view = PostTrackTimes.get_last_view(post.id, session[:userid])
		@time = unless @get_last_view.size == 0
			@get_last_view.first.view_time.nil? ? 0 : @get_last_view.first.view_time
		else
			0
		end
		@size = post.post_comments.where([DATED_QUERY, @time]).where.not(content: nil).size
		@size > 0 ? "<strong>новых #{@size}</strong>" : "новых нет"
	end
end