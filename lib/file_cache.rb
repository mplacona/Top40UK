class FileCache
	def initialize (base_dir, max_age)
        @base_dir = base_dir
        @max_age  = max_age
    end

    def make_filename(key)
    	File.join @base_dir, key.gsub(/[^0-9a-z]/i, '_') + ".cache"
    end

    def get(key)
    	filename = make_filename(key)

    	if File.exists? filename
    		if Time.now - File.mtime(filename) <= @max_age
    			return IO.read(filename)
    		else
    			File.delete filename
    		end
    	end

    	# If we got here, yield to generate the data
    	data = yield
    	set(key, data)
    	return data
    end

    def set(key, data)
        File.open(make_filename(key), 'w') do |f|
            f << data
        }
    end

end