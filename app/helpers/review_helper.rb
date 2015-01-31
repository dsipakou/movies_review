module ReviewHelper
	def get_stars(i, review)
		unless review.stars.nil?
			'on' unless i > review.stars
		end
	end
end
