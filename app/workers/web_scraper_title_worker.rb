require 'open-uri'

class WebScraperTitleWorker
  include Sidekiq::Worker

  def perform(url)
    page = Nokogiri::HTML(open(url =~ /https?:\/\/[\S]+/ ? url : "http://#{url}"))
    title = page.at_css("head").at_css("title").text
    website = Website.find_by(url: url)
    website.title = title
    website.processing_title = false
    website.save
  end
end
