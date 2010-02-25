#!/usr/bin/env ruby

require "rubygems"
require "active_support"
time = 1.minutes.since Time.now

def register_job(j = { :month => "*", :day => "*", :week => "1-5", :hour => "*", :min => "*", :wav => "" })
  [j[:min], j[:hour], j[:day], j[:month], j[:week], "aplay", "#{ Dir.pwd }/wav/#{ j[:wav] }.wav", "\n"].join(" ")
end

JOBS =
[
register_job(:month => "4-12"                                   , :hour => "8"           , :min => "20", :wav => "chaim"),
register_job(                                   :week => "1-6"  , :hour => "0 9,12,17,18", :min => "0" , :wav => "chaim"),
register_job(                                                     :hour => "8"           , :min => "56", :wav => "manner_mode"),
register_job(                                   :week => "1,3,5", :hour => "13"          , :min => "0" , :wav => "radio_exercise01"),
register_job(                                   :week => "2,4"  , :hour => "13"          , :min => "0" , :wav => "radio_exercise02"),
register_job(:month => "6-9"                  , :week => "4"    , :hour => "17"          , :min => "1" , :wav => "all_cleaning"),
register_job(:month => "1-5,10-12"            , :week => "4"    , :hour => "13"          , :min => "4" , :wav => "all_cleaning"),
register_job(                                                     :hour => "8"           , :min => "56", :wav => "before_15minutes"),
register_job(:month => "2"   , :day => "1-7"                    , :hour => "19"          , :min => "58", :wav => "hotaru"),
register_job(:month => "2"   , :day => "8-29"                   , :hour => "21"          , :min => "45", :wav => "before_15minutes"),
register_job(:month => "2"   , :day => "8-29"                   , :hour => "21"          , :min => "58", :wav => "hotaru"),
register_job(:month => "3"   , :day => "1-15"                   , :hour => "21"          , :min => "45", :wav => "before_15minutes"),
register_job(:month => "1"                                      , :hour => "20"          , :min => "45", :wav => "before_15minutes"),
register_job(:month => "1"                                      , :hour => "20"          , :min => "58", :wav => "hotaru"),
register_job(:month => "2"   , :day => "1-7"                    , :hour => "19"          , :min => "45", :wav => "before_15minutes"),
register_job(:month => "2"   , :day => "1-7"                    , :hour => "19"          , :min => "58", :wav => "hotaru"),
register_job(:month => "2"   , :day => "8-29"                   , :hour => "21"          , :min => "45", :wav => "before_15minutes"),
register_job(:month => "2"   , :day => "8-29"                   , :hour => "21"          , :min => "58", :wav => "hotaru"),
register_job(:month => "3"   , :day => "1-15"                   , :hour => "21"          , :min => "45", :wav => "before_15minutes"),
register_job(:month => "3"   , :day => "1-15"                   , :hour => "21"          , :min => "58", :wav => "hotaru"),
register_job(:month => "3"   , :day => "16-31"                  , :hour => "20"          , :min => "45", :wav => "before_15minutes"),
register_job(:month => "3"   , :day => "16-31"                  , :hour => "20"          , :min => "58", :wav => "hotaru"),
register_job(:month => "4"                                      , :hour => "19"          , :min => "45", :wav => "before_15minutes"),
register_job(:month => "4"                                      , :hour => "19"          , :min => "58", :wav => "hotaru"),
register_job(:month => "5"   , :day => "1-5"                    , :hour => "19"          , :min => "45", :wav => "before_15minutes"),
register_job(:month => "5"   , :day => "1-5"                    , :hour => "19"          , :min => "58", :wav => "hotaru"),
register_job(:month => "5"   , :day => "6-25"                   , :hour => "20"          , :min => "45", :wav => "before_15minutes"),
register_job(:month => "5"   , :day => "6-25"                   , :hour => "20"          , :min => "58", :wav => "hotaru"),
register_job(:month => "5"   , :day => "26-31"                  , :hour => "19"          , :min => "45", :wav => "before_15minutes"),
register_job(:month => "5"   , :day => "26-31"                  , :hour => "19"          , :min => "58", :wav => "hotaru"),
register_job(:month => "6-12"                                   , :hour => "19"          , :min => "45", :wav => "before_15minutes"),
register_job(:month => "6-12"                                   , :hour => "19"          , :min => "58", :wav => "hotaru")#,
#register_job(:hour => time.hour.to_s, :min => time.min.to_s, :wav => "chaim")
]

user = Dir.entries("/home").reject { |d| /\.|\.\./ =~ d }
cron = "/var/spool/cron/crontabs/#{ user }"
File.open(cron, "w") do |line|
  JOBS.each { |job| line.write(job) }
end
require "fileutils"
FileUtils.chmod(0600, cron, :verbose => true)
FileUtils.chown(user, nil, cron, :verbose => true)
system "service cron restart"
