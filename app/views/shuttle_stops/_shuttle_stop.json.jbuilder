json.extract! shuttle_stop, :id, :shuttle_id, :order, :address, :latitude, :longitude, :person_count, :created_at, :updated_at
json.url shuttle_stop_url(shuttle_stop, format: :json)
