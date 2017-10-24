class Url < ApplicationRecord
	def to_param
		self.short_url.to_s
	end
end
