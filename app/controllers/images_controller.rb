class ImagesController <  ApplicationController

	def create
		upload = params[:upload][:imagefile]
		if !upload.content_type.starts_with?('image')
			flash[:error] = 'Only images can be uploaded.'
			redirect_to :root
			return
		end
		flash[:success] = 'Successfully uploaded.' if Aws3::Bucket.rtp.upload_file(upload)
		redirect_to :root
	end

	def index
		@images = Aws3::Bucket.published.list_resources(marker: params[:marker])

		respond_to do |format|

		  format.html
		  format.json { render json: @images }

		 end
	end
end