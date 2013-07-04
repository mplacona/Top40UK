# Add lib directory to load path
$:.unshift File.join(File.dirname(__FILE__), 'lib')

require 'rubygems'
require 'sinatra'
require 'json'
require 'haml'
require File.join(File.dirname(__FILE__), 'settings')

require 'chart'

configure do
  set :views, "#{File.dirname(__FILE__)}/views"
end

get '/' do
    haml :index
end

get '/chart/:country/:type.json' do
    cache_key = "chart_#{params[:country]}_#{params[:type]}"

    json = Config.cache.get(cache_key) do
        chart = Chart.create params[:country].to_sym
        JSON.pretty_generate chart.get params[:type].to_sym
    end

    content_type :json
    json
end

# Redirect the old URLs
get '/top-40-single.json' do
    redirect to('/chart/gb/singles.json'), 301
end

get '/top-40-album.json' do
    redirect to('/chart/gb/albums.json'), 301
end
