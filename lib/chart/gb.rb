require 'net/http'
require 'nokogiri'
require 'open-uri'
require 'time'

class GBChart

	TYPE_URLS = {
		:singles => 'http://www.bbc.co.uk/radio1/chart/singles/print',
		:albums => 'http://www.bbc.co.uk/radio1/chart/albums/print'
	}

	def get(type)
		case type
		when :singles
			create_output_structure(TYPE_URLS[:singles])
		when :albums
			create_output_structure(TYPE_URLS[:albums])
		else
			raise ArgumentError, 'Unknown chart type'
		end
	end

	def parse_entries(doc)
	    doc.xpath('//table[@border="1"]/tr[not(th)]').collect do |row|
	    {
			:position => row.at("td[1]/text()").content.to_i,
			:noWeeks  => row.at("td[4]/text()").content.to_i,
			:artist   => row.at("td[5]/text()").content,
			:title    => row.at("td[6]/text()").content,
			:change => {
				:status   => row.at("td[2]/text()").content.strip,
				:previous => row.at("td[3]/text()").content.to_i
			}
		}
	    end
	end

	def get_data(url)
		Net::HTTP.get_response(URI.parse(url)).body
	end

	def create_output_structure(url)
		doc = Nokogiri::HTML( get_data(url) )

		chart_date = Time.parse doc.at('//h2/text()').content.split(' - ')[1] + " 12:00:00"

		entries = parse_entries(doc)

		time = Time.now
		{
			:chartDate => chart_date.to_i,
			:retrieved => Config.retrieved,
			:entries   => entries
		}
	end

end