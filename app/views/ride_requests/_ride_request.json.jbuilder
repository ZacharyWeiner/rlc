json.extract! ride_request, :id, :pickup_address, :dropoff_address, :riders, :requester_name, :shuttle_id, :completed, :created_at, :updated_at
json.url ride_request_url(ride_request, format: :json)
