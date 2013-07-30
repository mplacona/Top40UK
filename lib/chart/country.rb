require 'net/http'
require 'nokogiri'
require 'open-uri'
require 'time'

class CountryChart
    def initialize(urls)
        @urls = urls
    end

    def get(type)
        case type
        when :singles
            create_output_structure(@urls[:singles]) 
        when :albums
            create_output_structure(@urls[:albums])
        else    
            raise ArgumentError, 'Unknown chart type'
        end     
    end
    
    def calculate_move(previous, position, weeks)
        difference = previous - position        
        case
        when difference < 0
            if(weeks == 1)
              "new"
            else
                "down #{difference.abs}"
            end
        when difference > 0
            "up #{difference}"
        else
            "non-mover"
        end
    end

    def get_data(url)
        Net::HTTP.get_response(URI.parse(url)).body
        #File.read("singles.html")
    end
end
