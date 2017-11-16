#!/bin/sh
cd /usr/app
pwd
ruby -v
ls -la
bundle install

ruby runner.rb
