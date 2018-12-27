module Aws3
	class Resource
		attr_accessor :bucket, :object
		def initialize(bucket, object)
			self.bucket = bucket
			self.object = object
		end

		def public_url
			s3_object.public_url
		end

		def download(download_path)
			s3_object.get(response_target: download_path)
		end

		def delete
			s3_object.delete
		end

		private
		
		def s3_object
			@s3_object ||= Aws::S3::Resource.new.bucket(self.bucket.name).object(self.object.key)
		end
		
	end
end