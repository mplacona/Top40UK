class Chart
	def self.create(country)
		case country
		when :gb
			GBChart.new
		else
			raise ArgumentException, 'Unknown country code.'
		end
	end
end

require 'chart/gb'