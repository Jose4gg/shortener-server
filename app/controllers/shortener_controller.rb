class ShortenerController < ApplicationController

  def create
    params.require(:url)
    url = params[:url].chomp "/".downcase

    website = Website.find_or_initialize_by(url: url)


    if website.persisted?
      render json: website, methods: :short_url
    elsif website.save
      render json: website, methods: :short_url
    else
      render json: { errors: website.errors.values.flatten }
    end
  end

  def show
    website = Website.find_by_short_id(params[:id])
    website.update(visited_count: website.visited_count + 1)
    redirect_to website.url =~ /https?:\/\/[\S]+/ ? website.url : "//#{website.url}"
  end

  def index
    render json: Website.order(visited_count: :desc).limit(100), methods: :short_url
  end

  rescue_from ActionController::ParameterMissing do |exception|
    render json: { "errors" => ["#{exception.param} is required"] }, status: 400
  end
end
