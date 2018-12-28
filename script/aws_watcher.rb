#!/usr/bin/env ruby
require 'rubygems'
require 'daemons'

options = {
  :app_name   => "aws_watcher",
  :dir_mode   => :normal,
  :dir        => File.join(File.dirname(__FILE__),'..','tmp','pids' ),
  :backtrace  => true,
  :monitor    => true
}

Daemons.run(File.join(File.dirname(__FILE__),'aws_watcher_daemon.rb'), options)
