#!/bin/bash

sudo apt-get -y install ruby rubygems
sudo chmod u+x schedule.rb
gem install activesupport
cp -r ../alarm $HOME
cd $HOME/alarm
sudo $HOME/alarm/schedule.rb
