json.array!(@movies) do |movie|
  json.extract! movie, :id, :title, :orig_title, :year, :link, :image
  json.url movie_url(movie, format: :json)
end
