require 'open-uri'
require 'nokogiri'

class GBChart

	TYPE_URLS = {
		:singles => 'http://www.bbc.co.uk/radio1/chart/singles/print',
		:albums => 'http://www.bbc.co.uk/radio1/chart/albums/print'
	}

	def get(type)
		case type
		when :singles
			create_output_structure(TYPE_URLS[:singles], Config.retrieved.to_s + ".single")
		when :albums
			create_output_structure(TYPE_URLS[:albums], Config.retrieved.to_s + ".album")
		else
			raise ArgumentError, 'Unknown chart type'
		end
	end

	def parse_url (url, key)
	    data = Config.getter.get( url, key )
	    Nokogiri::HTML(data).xpath('//table[@border="1"]/tr[not(th)]').collect do |row|
	        position            =       row.at("td[1]/text()").content.to_i
	        status              =       row.at("td[2]/text()").content.strip
	        previousPosition    =       row.at("td[3]/text()").content.to_i
	        noWeeks             =       row.at("td[4]/text()").content.to_i
	        artist              =       row.at("td[5]/text()").content
	        title               =       row.at("td[6]/text()").content
	        {:position => position, :noWeeks => noWeeks, :artist => artist, :title => title, :change => {:status => status, :previous => previousPosition}}
	    end
	end

	def create_output_structure(url, key)
	    entries = parse_url(url, key)
	    time = Time.now
	    {:chartDate => time.to_i, :retrieved => Config.retrieved, :entries => entries}
	end

end