module Aws3
	def self.client
		@client ||= Aws::S3::Client.new
	end

	def self.temp_cache_path
		File.join('/tmp', 'rtp')
	end

	def self.process_rtp
		bucket = Aws3::Bucket.rtp
		FileUtils.mkdir_p(temp_cache_path)

		Aws3.client.list_objects(bucket: bucket.name).each do |response|
			response.contents.each do |object|
				resource = Aws3::Resource.new(bucket, object)
				download_path = File.join(self.temp_cache_path,  object.key)
				resource.download(download_path)
				file = ImageUtils.resize_image(download_path)
				Aws3::Bucket.published.upload_file(file, name: object.key)
				resource.delete
			end
		end
	ensure
		FileUtils.rm_rf(self.temp_cache_path)
	end
end