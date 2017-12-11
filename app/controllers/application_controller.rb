class ApplicationController < ActionController::Base
  before_action :direct_to_app
  protect_from_forgery with: :exception

  def direct_to_app
    p "Domain " + request.domain
    if  request.subdomains.include?('shuttle')
      p "Subdomains: " + request.subdomains.first
      p 'Original Url' + request.original_url
      if request.original_url == "resortlodgingcompany.com"
        redirect_to new_ride_request_path
      end
    end
  end
end
