require File.expand_path(File.join(File.dirname(__FILE__),'..','config', 'environment'))
require "rubygems"

@logger = Logger.new(File.join(Rails.root, 'log', 'aws_watcher.log'))
def say(text, level = Logger::INFO)
  @logger.add level, "#{Time.now.strftime('%FT%T%z')}: #{text}" if @logger
end

while true do
	begin
  	Aws3.process_rtp
	rescue=>e
		say "ERROR : #{e.to_s}"
  	say e.backtrace
  end
  sleep 5
end
