require 'spec_helper'

describe 'UK Top 40 - Singles' do
    it "should load the UK top 40 singles" do
        get 'chart/gb/singles.json'
        last_response.should be_ok
    end

    it "should retrieve a content type of json for top 40 singles" do
        get 'chart/gb/singles.json'
        last_response.header['Content-Type'].should include 'application/json'
    end
end

describe 'UK Top 40 - Albums' do
    it "should load the UK top 40 albums" do
        get 'chart/gb/albums.json'
        last_response.should be_ok
    end

    it "should include a content type of json for top 40 albums" do
        get 'chart/gb/albums.json'
        last_response.header['Content-Type'].should include 'application/json'
    end
end

describe 'US Top 40 - Singles' do
    it "should load the US top 40 singles" do
        get 'chart/us/singles.json'
        last_response.should be_ok
    end

    it "should retrieve a content type of json for top 40 singles" do
        get 'chart/us/singles.json'
        last_response.header['Content-Type'].should include 'application/json'
    end
end

describe 'FR Top 40' do
    it "should load the FR top 40 singles" do
        get 'chart/fr/singles.json'
        last_response.should be_ok
    end

    it "should load the FR top 40 albums" do
        get 'chart/fr/albums.json'
        last_response.should be_ok
    end
end
