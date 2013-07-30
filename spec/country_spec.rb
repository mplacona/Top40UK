require 'spec_helper'
require 'chart/country'

describe "CountryChart" do
    before(:all) do
        TYPE_URLS = {
            :singles => 'http://www.bbc.co.uk/radio1/chart/singles/print',
            :albums => 'http://www.bbc.co.uk/radio1/chart/updatealbums/print'
        } 
        @country_chart = CountryChart.new TYPE_URLS
    end

    it "should take one parameter and return an instance of CountryChart" do
        @country_chart.should be_an_instance_of CountryChart
    end

    it "should return the difference (up or down) between two numbers" do
        move = @country_chart.calculate_move 5, 3, 2
        move.should eql "up 2"
    end

    it "should say 'new' regardless when difference is down if the chart has only been there for a week" do
        move = @country_chart.calculate_move 0, 3, 1
        move.should eql "new"
    end

    it "should say 'non-mover' if position and previous are still the same" do
        move = @country_chart.calculate_move 1, 1, 1
        move.should eql "non-mover"
    end

    it "shoud raise exception when calling extract_date internally" do
        expect {@country_chart.extract_date String.new}.to raise_error(NotImplementedError)
    end

end

