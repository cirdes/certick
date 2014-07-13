module CertifiedsHelper

	def slug_full_url certified
		root_url + "generate/#{certified.slug}"
	end
	
	protected

    def generate_token
      token = loop do
        random_token = SecureRandom.urlsafe_base64(nil, false)
        break random_token unless Certified.where(slug: random_token).exists?
      end
    end
end
