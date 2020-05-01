class HomeController < ApplicationController


  def index
  	@short_url = ShortUrl.new
  end

  def show
  	@short_url = current_short_url
  	if @short_url.is_expired?
  		render :file => "#{Rails.root}/public/404.html", layout: false, status: :not_found
  	else
  		@short_url.update_tracked_data
  		redirect_to @short_url.url
  	end
  end

  def create
  	@short_url = current_short_url
  end

  def stats
  	@short_urls = StatsViewModel.new.short_urls
  end

  private 

  def current_short_url
  	 CreateShortUrl.new(params, request)
  end
end

