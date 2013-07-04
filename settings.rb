require 'ostruct'
require 'file_cache'

time = Time.now

configure do
    Config = OpenStruct.new(
        :retrieved => Time.new(time.year, time.month, time.day).to_i,
        :cache => FileCache.new( File.join(File.dirname(__FILE__), 'cache'), 3600 )
    )
end
