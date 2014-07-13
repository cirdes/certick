module GenerateHelper
	def slug_full_url certified
		root_url + "generate/#{certified.slug}"
	end
end
