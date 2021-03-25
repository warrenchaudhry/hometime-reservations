json.extract! reservation, :id, :created_at, :updated_at
json.url reser_url(reservation, format: :json)
