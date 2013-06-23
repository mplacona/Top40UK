require 'rubygems'
require 'sinatra'
require 'open-uri'
require 'nokogiri'
require 'json'
require 'haml'
require File.join(File.dirname(__FILE__), 'HTTPCacher')

top_40_singles  = 'http://www.bbc.co.uk/radio1/chart/singles/print'
top_40_albuns   = 'http://www.bbc.co.uk/radio1/chart/albums/print'

# Retrieval time
time = Time.now
retrieved = Time.new(time.year, time.month, time.day).to_i

# initialize cache
$getter = HTTPCacher.new( File.dirname(__FILE__) + "/cache" )

configure do
  set :views, "#{File.dirname(__FILE__)}/views"
end

def parse_url (url, retrieved)
    data = $getter.get( url, retrieved)
    puts @retrieved
    Nokogiri::HTML(data).xpath('//table[@border="1"]/tr').collect do |row|
        position            =       row.at("td[1]/text()")
        status              =       row.at("td[2]/text()")
        previousPosition    =       row.at("td[3]/text()")
        noWeeks             =       row.at("td[4]/text()")
        artist              =       row.at("td[5]/text()")
        title               =       row.at("td[6]/text()")
        {:position => position, :noWeeks => noWeeks, :artist => artist, :title => title, :change => {:status => status, :previous => previousPosition}}
    end
end

def create_output_structure(url, retrieved)
    entries = parse_url(url, retrieved)
    entries.delete_at(0) #unnecessary entry (hack)
    time = Time.now
    {:chartDate => time.to_i, :retrieved => retrieved, :entries => entries}
end

get '/' do
    haml :index
end

get '/top-40-single.json' do
    content_type :json
    JSON.pretty_generate(create_output_structure(top_40_singles, retrieved))
end

get '/top-40-album.json' do
    content_type :json
    JSON.pretty_generate(create_output_structure(top_40_albuns))
end
