#!/bin/bash
./script/aws_watcher.rb start

bundle exec rails s -p 3000 -b '0.0.0.0'