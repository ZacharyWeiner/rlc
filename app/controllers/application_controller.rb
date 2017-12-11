class ApplicationController < ActionController::Base
  before_action :direct_to_app
  layout :layout_by_resource
  protect_from_forgery with: :exception

  def direct_to_app
    p "Domain " + request.domain
    if  request.subdomains.include?('shuttle')
      p "Subdomains: " + request.subdomains.first
      p 'Original Url' + request.original_url
      if request.original_url == "http://shuttle.resortlodgingcompany.com/"
        redirect_to new_ride_request_path
      end
    end
  end

  def layout_by_resource
    if devise_controller?
      "devise"
    else
      "application"
    end
  end
end
