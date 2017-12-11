class ApplicationController < ActionController::Base
  before_action :direct_to_app
  protect_from_forgery with: :exception

  def direct_to_app
    p request.domain
    if  request.subdomains.include?('shuttle')
      p request.subdomains
      if request.original_url == "resortlodgingcompany.com"
        p request.original_url
        redirect_to new_ride_request_path
      end
    end
  end
end
