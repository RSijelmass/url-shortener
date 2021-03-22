class UrlInstancesController < ApplicationController
  def create
    input_url = params[:input_url]
    shorthand_url = UrlParser.create_shorthand

    @url_instance = UrlInstance.new(longhand: input_url, shorthand: shorthand_url)
    @url_instance.save
  end
end
