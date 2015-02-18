class Movie < ActiveRecord::Base

	has_many :reviews, :dependent => :destroy
	has_many :comments, :dependent => :destroy
	has_many :track_times
	belongs_to :user

	validates :title, presence: true, uniqueness: true
	validates :orig_title, uniqueness: true

	def self.sorting_by(param)
  		case param
			when "1"
				Movie.joins(:reviews).where("reviews.content <> '' OR reviews.stars <> '' OR reviews.awesome <> ''").order('reviews.updated_at DESC').first(100000).uniq().first(20)
			when "2"
				Movie.order("created_at DESC").first(20)
			when "3"
				Movie.joins(:comments).order('comments.updated_at DESC').first(100000).uniq().first(20)
			when "4"
				Movie.joins(:reviews).where.not(reviews: {content: nil}).group("reviews.movie_id").order("count(reviews.movie_id) DESC").first(20)
			when "5"
				Movie.joins(:reviews).where(reviews: {awesome: 1}).group("reviews.movie_id").order("count(reviews.movie_id) DESC").first(20)
		else
			Movie.joins(:reviews).where("reviews.content <> '' OR reviews.stars <> '' OR reviews.awesome <> ''").order('reviews.updated_at DESC').first(100000).uniq().first(20)
		end
	end

	def self.search(query)
		Movie.where("title LIKE ? OR orig_title LIKE ?", query, query)
	end

	def self.get_years()
		Movie.where("year <> ''").uniq().order('year DESC')
	end
end
