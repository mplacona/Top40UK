class Chart
	def self.create(country)
		case country
		when :gb
			GBChart.new
        when :us
            USChart.new
        when :fr
            FRChart.new
		else
			raise ArgumentException, 'Unknown country code.'
		end
	end
end

require 'chart/gb'
require 'chart/us'
require 'chart/fr'
