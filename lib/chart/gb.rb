class GBChart

	def get(type)
		case type
		when :singles
			raise NotImplementedError, 'Soon'
		when :albums
			raise NotImplementedError, 'Soon'
		else
			raise ArgumentError, 'Unknown chart type'
		end
	end

end