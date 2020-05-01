class StatsViewModel
	attr_reader :short_urls

	def initialize(model = nil)
    @model = model
    @all_short_urls = all_urls
    @short_urls = get_short_urls
  end

	def all_urls
	  all_short_urls = ShortUrl.includes(:visit_tracks)
	end

	def get_short_urls
		@all_short_urls.map do |short_url|
			ShortUrlViewModel.new(short_url)
		end
	end

end