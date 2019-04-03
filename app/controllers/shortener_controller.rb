class ShortenerController < ApplicationController

  def create
    params.require(:url)
    url = params[:url].chomp "/"

    website = Website.find_or_initialize_by(url: url)


    if website.persisted?
      render json: { short_url: request.base_url + "/#{website.short_id}", visited_count: website.visited_count }
    elsif website.save
      render json: { short_url: request.base_url + "/#{website.short_id}", visited_count: website.visited_count }
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
    render json: Website.order(visited_count: :desc).limit(100), methods: :short_id
  end

  rescue_from ActionController::ParameterMissing do |exception|
    render json: { "errors" => ["#{exception.param} is required"] }, status: 400
  end
end
