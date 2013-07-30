require 'net/http'
require 'nokogiri'
require 'open-uri'
require 'time'
require 'chart/country'

class GBChart < CountryChart

	TYPE_URLS = {
		:singles => 'http://www.bbc.co.uk/radio1/chart/singles/print',
		:albums => 'http://www.bbc.co.uk/radio1/chart/updatealbums/print'
	}

    def initialize
        super(TYPE_URLS)
    end

	def parse_entries(doc)
	    doc.xpath('//table//tr[not(th)]').collect do |row|
			{
				:position => row.at("td[1]").content.to_i,
				:noWeeks  => row.at("td[4]").content.to_i,
				:artist   => row.at("td[5]").content,
				:title    => row.at("td[6]").content,
				:change => {
					:status   => row.at("td[2]").content.strip,
					:previous => row.at("td[3]").content.to_i
				}
			}
	    end
	end

    def extract_date(doc)
        Time.parse doc.at('//h1').content.split(' - ')[1] + " 12:00:00"
    end

end
