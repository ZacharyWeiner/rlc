class Shuttle < ApplicationRecord
  has_many :ride_requests
  reverse_geocoded_by :current_lat, :current_long
  after_validation :reverse_geocode  # auto-fetch address


  def available_seats
    riders = 0
    self.ride_requests.where(status: "Rolling").each do |request|
      riders = riders + request.riders
    end
    return self.capacity - riders
  end

  def continue_ordering(pickups, dropoffs)
    if pickups.count > 0
      return true
    end
    if dropoffs.count > 0
      return true
    end

    return false
  end

  def get_ordered_stops
    @rides = self.ride_requests.where.not(completed: true)
    @pickups_with_distance = []
    @dropoffs_with_distance = []
    @ordered_stops = []
    @potential_dropoffs = []

    @rides.each do |ride |
      pickup_location = Location.where(name: ride.pickup_address.split(",")[0]).first
      dropoff_location = Location.where(name: ride.dropoff_address.split(",")[0]).first

      distance_between_stops = Geocoder::Calculations.distance_between([pickup_location.latitude, pickup_location.longitude], [dropoff_location.latitude, dropoff_location.longitude])

      @pickups_with_distance << RideAndDistance.new(ride_id: ride.id,
        stop_type: "pickup",
        address: ride.pickup_address,
        name: ride.requester_name,
        phone: ride.phone,
        lat: pickup_location.latitude,
        long:pickup_location.longitude,
        distance: Geocoder::Calculations.distance_between([self.current_lat,self.current_long], [pickup_location.latitude, pickup_location.longitude]))

      @do =  RideAndDistance.new(ride_id: ride.id,
        stop_type: "dropoff",
        name: ride.requester_name,
        phone: ride.phone,
        address: ride.dropoff_address,
        lat: dropoff_location.latitude,
        long:dropoff_location.longitude,
        distance: Geocoder::Calculations.distance_between([self.current_lat,self.current_long], [dropoff_location.latitude, dropoff_location.longitude]))

      @dropoffs_with_distance << @do
    end
    @ordered_pickups  = @pickups_with_distance.sort {|a, b| a.distance <=> b.distance}
    @ordered_dropoffs  = @dropoffs_with_distance.sort {|a, b| a.distance <=> b.distance}

    in_shuttle = []
    comparison_list = []

    #put first pickup in ordered stops
    @ordered_stops << @ordered_pickups.first

    #add ride to list for dropoff OK
    in_shuttle << @ordered_pickups.first.ride_id

    #remove pickup from pickup list
    @ordered_pickups.delete_at(0)

    current_stop = @ordered_pickups.first

    while (self.continue_ordering(@ordered_pickups, @ordered_dropoffs)) do
      #get potential dropoffs
      potential_dropoffs = []
      @ordered_dropoffs.each do  |d|
        if in_shuttle.include?(d.ride_id)
          potential_dropoffs << d
        end
      end


      #compare next pickup to all potential dropoffs
      comparison = []
      potential_dropoffs.each do |pd|
        comparison << pd
      end
      unless @ordered_pickups.first.nil?
        comparison << @ordered_pickups.first
      end

      ordered_comparison = comparison.sort{|a,b| Geocoder::Calculations.distance_between(
                                                    [a.lat, a.long],[current_stop.lat, current_stop.long]) <=> Geocoder::Calculations.distance_between([b.lat, b.long], [current_stop.lat, current_stop.long])}

      #if there are no more pickups but there are still dropoffs


      #if dropoff is closer than the next pickup

      if ordered_comparison.first.stop_type == "dropoff"
        @ordered_stops << ordered_comparison.first
        index = @ordered_dropoffs.index(ordered_comparison.first)
        @ordered_dropoffs.delete_at(index)
      #if a pickup is closer than the next dropoff
      else
        #add the closer pickup to the ordered stops list
        @ordered_stops << ordered_comparison.first
        #indicate that the pick up is in the shuttle so dropoff is added to potential dropoff list
        in_shuttle << ordered_comparison.first.ride_id

        #remove the pickup from being able to be selected again
        @ordered_pickups.delete_at(0)
      end
      current_stop = ordered_comparison.first
    #end While Statement
    end
    @ordered_stops
  end
end
