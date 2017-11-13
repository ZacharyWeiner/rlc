json.extract! shuttle, :id, :current_lat, :current_long, :previous_lat, :previous_long, :name, :address, :created_at, :updated_at
json.url shuttle_url(shuttle, format: :json)
