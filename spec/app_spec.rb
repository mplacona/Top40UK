require 'spec_helper'

describe 'UK Top 40 - Singles' do
    it "should load the UK top 40 singles" do
        get 'top-40-single.json'
        last_response.should be_ok
    end

    it "should retrieve a content type of json for top 40 singles" do
        get 'top-40-single.json'
        last_response.header['Content-Type'].should include 'application/json'
    end
end

describe 'UK Top 40 - Albums' do
    it "should load the UK top 40 albums" do
        get 'top-40-album.json'
        last_response.should be_ok
    end

    it "should include a conatent type o json for top 40 albums" do
        get 'top-40-album.json'
        last_response.header['Content-Type'].should include 'application/json'
    end
end
