#!/bin/bash
export PATH=/home/ubuntu/.rvm/gems/ruby-3.0.4/bin:/home/ubuntu/.rvm/gems/ruby-3.0.4@global/bin:/home/ubuntu/.rvm/rubies/ruby-3.0.4/bin:/home/ubuntu/bin:/home/ubuntu/.local/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin:/home/ubuntu/.rvm/bin:/home/ubuntu/.rvm/bin
sudo kill -9 $(cat /var/www/my-app/tmp/pids/server.pid)
cd /var/www/my-app/
gem install bundler — user-install
bundle install
yarn install

