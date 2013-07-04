require 'open-uri'
require 'nokogiri'

class GBChart

	def get(type)
		case type
		when :singles
			create_output_structure(Config.top_40_singles, Config.retrieved.to_s + ".single")
		when :albums
			create_output_structure(Config.top_40_albums, Config.retrieved.to_s + ".album")
		else
			raise ArgumentError, 'Unknown chart type'
		end
	end

	def parse_url (url, key)
	    data = Config.getter.get( url, key )
	    Nokogiri::HTML(data).xpath('//table[@border="1"]/tr').collect do |row|
	        position            =       row.at("td[1]/text()")
	        status              =       row.at("td[2]/text()").to_s.chomp
	        previousPosition    =       row.at("td[3]/text()")
	        noWeeks             =       row.at("td[4]/text()")
	        artist              =       row.at("td[5]/text()")
	        title               =       row.at("td[6]/text()")
	        {:position => position, :noWeeks => noWeeks, :artist => artist, :title => title, :change => {:status => status, :previous => previousPosition}}
	    end
	end

	def create_output_structure(url, key)
	    entries = parse_url(url, key)
	    entries.delete_at(0) #unnecessary entry (hack)
	    time = Time.now
	    {:chartDate => time.to_i, :retrieved => Config.retrieved, :entries => entries}
	end


end