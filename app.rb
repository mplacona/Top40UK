require 'rubygems'
require 'sinatra'
require 'open-uri'
require 'nokogiri'
require 'json'
require 'haml'
require File.join(File.dirname(__FILE__), 'settings')

configure do
  set :views, "#{File.dirname(__FILE__)}/views"
end

def parse_url (url, key)
    data = Config.getter.get( url, key )
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

def create_output_structure(url, key)
    entries = parse_url(url, key)
    entries.delete_at(0) #unnecessary entry (hack)
    time = Time.now
    {:chartDate => time.to_i, :retrieved => Config.retrieved, :entries => entries}
end

get '/' do
    haml :index
end

get '/top-40-single.json' do
    content_type :json
    JSON.pretty_generate(create_output_structure(Config.top_40_singles, Config.retrieved.to_s + ".single"))
end

get '/top-40-album.json' do
    content_type :json
    JSON.pretty_generate(create_output_structure(Config.top_40_albuns, Config.retrieved.to_s + ".album"))
end
