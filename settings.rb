require 'ostruct'
require 'file_cache'
require File.join(File.dirname(__FILE__), 'HTTPCacher')

time = Time.now

configure do
    Config = OpenStruct.new(
        :retrieved => Time.new(time.year, time.month, time.day).to_i,
        :getter => HTTPCacher.new( File.dirname(__FILE__) + "/cache" ),
        :cache => FileCache.new( File.join(File.dirname(__FILE__), 'cache'), 3600 )
    )
end
