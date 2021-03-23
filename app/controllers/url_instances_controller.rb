class UrlInstancesController < ApplicationController
  skip_before_action :verify_authenticity_token

  def show
    @url_instance = UrlInstance.find(params[:id])
  end

  def create
    input_url = params[:input_url]

    unless UrlParser.is_valid_url? input_url
      render body: "Failed to store URL: #{input_url} is not valid", :status => :bad_request
      return
    end

    shorthand_url = UrlParser.create_shorthand

    @url_instance = UrlInstance.new(longhand: input_url, shorthand: shorthand_url)
    if @url_instance.save
      redirect_to @url_instance
    else
      render body: "Failed to store UrlInstance", :status => :internal_server_error
    end
  end
end
