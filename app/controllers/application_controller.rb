class ApplicationController < ActionController::Base
  before_action :direct_to_app
  protect_from_forgery with: :exception

  def direct_to_app
    if  request.subdomains.include?('shuttle')
      if request.original_url == "resortlodgingcompany.com"
        redirect_to new_ride_request_path
      end
    end
  end
end
