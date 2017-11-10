json.extract! reservation, :id, :name, :phone, :experience_id, :count, :created_at, :updated_at
json.url reservation_url(reservation, format: :json)
