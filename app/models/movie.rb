class Movie < ActiveRecord::Base

	has_many :reviews, :dependent => :destroy
	has_many :comments, :dependent => :destroy
	has_many :track_times
	belongs_to :user

	validates :title, presence: true

	def self.sorting_by(query, param)
  		case param
			when "1"
				query = query.joins(:reviews).where("reviews.content <> '' OR reviews.stars <> '' OR reviews.awesome <> ''").order('reviews.updated_at DESC').first(100000).uniq().first(20)
			when "2"
				query = query.order("created_at DESC").first(20)
			when "3"
				query = query.joins(:comments).order('comments.updated_at DESC').first(100000).uniq().first(20)
			when "4"
				query = query.joins(:reviews).where.not(reviews: {content: nil}).group("reviews.movie_id").order("count(reviews.movie_id) DESC").first(20)
			when "5"
				query = query.joins(:reviews).where(reviews: {awesome: 1}).group("reviews.movie_id").order("count(reviews.movie_id) DESC").first(20)
		else
			query = query.joins(:reviews).where("reviews.content <> '' OR reviews.stars <> '' OR reviews.awesome <> ''").order('reviews.updated_at DESC').first(100000).uniq().first(20)
		end
		query
	end

	def self.filter(params)
		params ||= {}
		query = Movie.all
		if params[:search_query].present?
			query = query.where("title LIKE ? OR orig_title LIKE ?", "%#{params[:search_query]}%", "%#{params[:search_query]}%")
		end
		if params[:year_filter].present?
			query = query.where(year: params[:year_filter])
		end
		if params[:view_filter].present?
			query = self.sorting_by(query, params[:view_filter])
		end
		query
	end

	def self.search(query)
		Movie.where("title LIKE ? OR orig_title LIKE ?", query, query)
	end

	def self.get_years()
		Movie.where("year <> ''").order('year DESC').uniq.pluck(:year)
	end

	def self.by_year(year)
		Movie.where("year in (#{year})")
	end
end
