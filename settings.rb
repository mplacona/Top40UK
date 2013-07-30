require 'ostruct'
require 'file_cache'

configure do
    Config = OpenStruct.new(
        :cache => FileCache.new( File.join(File.dirname(__FILE__), 'cache'), 3600, true )
    )
end
