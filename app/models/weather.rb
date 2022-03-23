class Weather < ApplicationRecord
	def self.last_five
		last(5).reverse
	end
end
