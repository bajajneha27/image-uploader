# README

* Ruby version -> 2.4.5

* System dependencies ->  docker and docker-compose

* Configuration -> update 'config/settings.yml' and add AWS access_key and secret_access_key. Need to create a bucket named 'ot-rtp' for uploading the raw files and 'ot-published' for resized images with public access.

* How to run the test suite

	1. In the root folder, build the docker image.

			docker build -t image_builder .

	2. docker-compose up -d

* Open browser <ip-address>:3080

Overview:

1. Using imagemagick to resize the image.
2. uploader will upload the files to 'ot-rtp' bucket. 
3. Backend-service (watcher) will watch 'ot-rtp' bucket , resize them and push to 'ot-published' bucket.
4. on page, you can see the published images with pagination done with marker given by aws. It's not true pagination due to the restriction of AWS API.
