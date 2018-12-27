module ImageUtils
	def self.resize_image image_path
		image = MiniMagick::Image.open(image_path)
		image.resize "600x480>"
		image
	end
end