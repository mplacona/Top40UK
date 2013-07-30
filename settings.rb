require 'ostruct'
require 'file_cache'

time = Time.now

configure do
    Config = OpenStruct.new(
        :cache => FileCache.new( File.join(File.dirname(__FILE__), 'cache'), 3600, false )
    )
end
