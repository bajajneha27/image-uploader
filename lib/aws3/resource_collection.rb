module Aws3
	class ResourceCollection
		include Enumerable
		attr_accessor :s3_object_list, :bucket

		def initialize bucket, s3_object_list
			self.s3_object_list = s3_object_list
			self.bucket = bucket
			@resources = s3_object_list.contents.map do |object|
				Aws3::Resource.new(bucket, object)
			end
		end

		def each(&block)
	    @resources.each do |member|
	      block.call(member)
	    end
  	end

  	def last
  		@resources[-1]
  	end

  	def next_page?
  		s3_object_list.next_page?
  	end
	end
end