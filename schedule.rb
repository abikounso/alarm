#!/usr/bin/env ruby

require "rubygems"
require "active_support"
time = 1.minutes.since Time.now

JOBS =
[
["20 8 * 4-12 1-5", "chaim"],
["0 9,12,17,18 * * 1-6", "chaim"],
["56 8 * * 1-5", "manner_mode"],
["0 13 * * 1,3,5", "radio_exercise01"],
["0 13 * * 2,4", "radio_exercise02"],
["1 17 * 6-9 4", "all_cleaning"],
["4 13 * 1-5,10-12 4", "all_cleaning"],
["45 20 * 1 1-5", "before_15minutes"],
["58 20 * 1 1-5", "hotaru.wav"],
["45 20 1-25 5 1-5", "before_15minutes"],
["58 20 1-25 5 1-5", "hotaru"],
["45 19 26-31 5 1-5", "before_15minutes"],
["58 19 26-31 5 1-5", "hotaru"],
["45 19 1-15 2 1-5", "before_15minutes"],
["58 19 1-15 2 1-5", "hotaru"],
["45 21 16-29 2 1-5", "before_15minutes"],
["58 21 16-29 2 1-5", "hotaru"],
["45 21 1-15 3 1-5", "before_15minutes"],
["58 21 1-15 3 1-5", "hotaru"],
["45 19 16-31 3 1-5", "before_15minutes"],
["58 19 16-31 3 1-5", "hotaru"],
["45 19 * 4,6-12 1-5", "before_15minutes"],
["58 19 * 4,6-12 1-5", "hotaru"]#,
#["#{ time.min } #{ time.hour } * * *", "chaim"]
]

def play_wav(timing, name)
  "#{ timing } aplay #{ Dir.pwd }/wav/#{ name }.wav"
end

user = Dir.entries("/home").reject { |d| /\.|\.\./ =~ d }
cron = "/var/spool/cron/crontabs/#{ user }"
File.open(cron, "w") do |line|
  JOBS.each { |job| line.write(play_wav(job[0], job[1]) + "\n") }
end
require "fileutils"
FileUtils.chmod(0600, cron, :verbose => true)
FileUtils.chown(user, nil, cron, :verbose => true)
system "service cron restart"
