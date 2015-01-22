class FileOps

	attr_reader :image

	IMAGE_SAVE_PATH = "app/assets/images/posters/"
	IMAGE_DB_PATH	= "posters/"

	def get_image_from_url(url)
			image_name = rand(100000).to_s + "#{Time.now.usec}.png"
			File.open("#{IMAGE_SAVE_PATH}#{image_name}", 'wb') do |f|
				f.write open(url).read
			end
			image_name
	end
end