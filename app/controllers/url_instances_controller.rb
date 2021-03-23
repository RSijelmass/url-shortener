class UrlInstancesController < ApplicationController
  def create
    input_url = params[:input_url]
    unless UrlParser.is_valid_url? input_url
      render body: "Failed to store URL: #{input_url} is not valid", :status => :bad_request
      return
    end

    shorthand_url = UrlParser.create_shorthand

    @url_instance = UrlInstance.new(longhand: input_url, shorthand: shorthand_url)
    @url_instance.save
  end
end
