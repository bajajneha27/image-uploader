module Aws3
	class Bucket
		attr_accessor :name
		def initialize(name)
			self.name = name
		end
		def self.rtp
			@rtp ||= new(Settings.aws.rtp_bucket)
		end

		def self.published
			@published ||= new(Settings.aws.published_bucket)
		end

		def upload_file(file, options={})
			s3 = Aws::S3::Resource.new
			filename = options[:name] || generate_filename(file)
			obj = s3.bucket(self.name).object(filename)
			obj.upload_file(file.path)
		end

		def list_resources marker: nil, limit: 12
			objects = Aws3.client.list_objects(bucket: self.name, max_keys: limit, marker: marker)
			Aws3::ResourceCollection.new(self,objects)
		end

		private

		def generate_filename(file)
			[Digest::SHA1.hexdigest(file.read)[0..15], file.original_filename.gsub(/[^\w.-]+/,'')].join('-')
		end

	end
end