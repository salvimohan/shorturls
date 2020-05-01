class CreateShortUrl
	attr_reader :short_url, :params, :request, :all_short_codes

	def initialize(params, request)
    @request = request
    @params = params || {}
    @short_url = get_short_url
  end

  def get_short_url
  	if @params["action"] == "create"
  		create_short_url
  	elsif @params["action"] == "show"
  		find_short_url
  	end
  end

  def check_valid?
  	 @short_url.valid?
  end

  def create_short_url
  	@short_url = ShortUrl.find_by_url(@params[:short_url][:url])
  	if @short_url.nil?
  		all_codes
  		@short_url = ShortUrl.create(short_urls_params.merge(generate_url_short_code))
  	end
  end

  def find_short_url
    ShortUrl.find_by_url_short_code(@params[:id])
  end

  def url
     @short_url.url
  end

  def short_code_url
  	"#{ROOT_URL}#{@short_url.url_short_code}"
  end

  def is_expired?
     !(@short_url.present? && @short_url.created_at > 1.months.ago)
  end

  def update_tracked_data
  	visit_track = @short_url.visit_tracks.find_by_ip(@request.ip)
  	if visit_track.present?
  		visit_track.increment_visit!
  	else
   		visit_track_options = { ip: @request.ip}
      @short_url.visit_tracks.create(visit_track_options)
    end
  end

  def all_codes
  	@all_short_codes = ShortUrl.pluck(:url_short_code)
  end

	def generate_url_short_code
		code = generate_code
		if  @all_short_codes.include?(code)
			generate_url_short_code
		else
			{url_short_code: code}
		end
	end

	def generate_code
  		charset = Array('A'..'Z') + Array('a'..'z') + Array('0'..'9')
  		Array.new(5) { charset.sample }.join
	end

  def short_urls_params
  	@params.require(:short_url).permit(:url)
  end
 
end