require 'net/http'
require 'nokogiri'
require 'open-uri'
require 'time'
require 'chart/country'

class FRChart < CountryChart

	TYPE_URLS = {
		:singles => 'http://top40-charts.com/chart.php?cid=11',
		:albums => 'http://top40-charts.com/chart.php?cid=11'
	}

    def initialize
        super(TYPE_URLS)
    end

    def parse_entries(doc)
        doc.xpath('//tr[@class="latc_song"]').collect do |row|
			{
				:position => row.at("td[1]").content.to_i,
				:noWeeks  => row.at_xpath("td[8]/font").content.to_i,
                :artist => row.at("td[4]/table/tr/td[3]/a").content,
                :title    => row.at("div").content,
				:change => {
                    # calculate the difference from previous to positio
					:status   => calculate_move(row.at_xpath("td[3]/font").content.to_i, row.at("td[1]").content.to_i, row.at_xpath("td[8]/font").content.to_i),
					:previous => row.at_xpath("td[3]/font").content.to_i
				}
            }
        end
    end
    def extract_date(doc)
		Time.parse doc.at('//select[@name="date"]/option[@selected="selected"]').content + " 12:00:00"
    end
end
