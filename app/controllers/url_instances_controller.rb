class UrlInstancesController < ApplicationController
  before_action :login_required, except: [:redirect_from_short]
  skip_before_action :verify_authenticity_token

  def index
    @url_instances = current_user.url_instances
  end

  def show
    @url_instance = UrlInstance.find(params[:id])
  end

  def redirect_from_short
    @url_instance = UrlInstance.find_by_shorthand(params[:shorthand])

    if @url_instance.nil?
      render body: "No URL available with shorthand #{params[:shorthand]}", :status => :not_found
      return
    end

    @url_instance.count+= 1
    @url_instance.save

    redirect_to @url_instance.longhand
  end

  def create
    input_url = url_instance_params[:longhand]
    shorthand_url = UrlParser.create_shorthand

    return unless assert_valid_url(input_url)

    @url_instance = current_user.url_instances.new(longhand: input_url, shorthand: shorthand_url)
    @url_instance.save ? redirect_to(@url_instance) : redirect_to(url_instances_url, notice: "Failed to store URL instance.")
  end

  private

  def assert_valid_url(input_url)
    return true if UrlParser.is_valid_url? input_url

    redirect_to url_instances_url, notice: "Failed to store URL: #{input_url} is not valid"
    return false
  end

  def url_instance_params
    params.require(:url_instance).permit(:longhand)
  end
end
