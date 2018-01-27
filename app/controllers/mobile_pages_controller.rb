class MobilePagesController < ApplicationController
  layout 'shuttle_layout'
  def ride_request
    @lat = cookies[:latitude]
    @long = cookies[:longitude]
    t = Time.now
    hour_local_time = t.strftime("%H")
    p hour_local_time
    if hour_local_time.to_i >= 14
      @ordered_locations = Location.where(show_after_2: true).order(:priority)
    else
      if @lat.nil?
        @ordered_locations = Location.all.order(:priority)
      else
        @ordered_locations = Location.all.order(:priority)#Location.near([@lat, @long], 30)
      end
    end
    @ride_request = RideRequest.new
  end

  def create
  end

  def ride_request_details
    set_ride_request
  end

  private
  def set_ride_request
    @ride_request = RideRequest.find(params[:ride_request_id])
  end

end
