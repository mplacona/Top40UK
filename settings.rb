require 'ostruct'
require File.join(File.dirname(__FILE__), 'HTTPCacher')

time = Time.now

configure do
    Config = OpenStruct.new(
        :top_40_singles => 'http://www.bbc.co.uk/radio1/chart/singles/print',
        :top_40_albuns => 'http://www.bbc.co.uk/radio1/chart/albums/print',
        :retrieved => Time.new(time.year, time.month, time.day).to_i,
        :getter => HTTPCacher.new( File.dirname(__FILE__) + "/cache" )
    )
end
