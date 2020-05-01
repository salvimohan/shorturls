class ShortUrlViewModel

	def initialize(model = nil)
    @model = model
  end

	def url
	   @model.url
	end

	def short_code_url
		"#{ROOT_URL}#{@model.url_short_code}"
	end

	def visits_count
		@model.visit_tracks.sum("visits_count")
	end

	def top_countries
		@model.visit_tracks.group('country').sum("visits_count").keys.take(3).join(",")
	end

end