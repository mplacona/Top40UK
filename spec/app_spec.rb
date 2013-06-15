require 'spec_helper'

describe 'UK Top 40 - Sinatra App' do
    it "should load the UK top 40 singles" do
        get 'top-40-album.json'
        last_response.should be_ok
    end
end
