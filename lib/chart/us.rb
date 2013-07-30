require 'net/http'
require 'nokogiri'
require 'open-uri'
require 'time'
require 'chart/country'

class USChart < CountryChart

	TYPE_URLS = {
		:singles => 'http://top40-charts.com/chart.php?cid=27',
		:albums => 'http://top40-charts.com/chart.php?cid=28'
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

    def create_output_structure(url)
		doc = Nokogiri::HTML( get_data(url) )

		chart_date = Time.parse doc.at('//select[@name="date"]/option[@selected="selected"]').content + " 12:00:00"
		chart_date = Time.new chart_date.year, chart_date.month, chart_date.day

		entries = parse_entries(doc)

		{
			:chartDate => chart_date.to_i,
			:retrieved => Time.now.to_i,
			:entries   => entries
		}
	end
end
