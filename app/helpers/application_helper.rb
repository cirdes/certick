module ApplicationHelper
	def slug_full_url slug
		root_url + "generate/#{slug}"
	end
end
