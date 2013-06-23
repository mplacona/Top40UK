require 'open-uri'
require 'net/http'

class HTTPCacher
    def initialize ( base_dir )
        @base_dir = base_dir
    end

    def get ( url, key )
        cached_path = @base_dir + '/' + key.to_s
        if File.exists?( cached_path  )
            puts "Getting file #{key} from cache"
            return IO.read( cached_path )
        else
            puts "Getting file #{key} from URL #{url}"
            resp = Net::HTTP.get_response(URI.parse(url))
            data = resp.body

            File.open( cached_path, 'w') do |f|
                f.puts data
            end

            return data
        end
    end
end
