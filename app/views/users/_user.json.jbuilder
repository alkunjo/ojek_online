json.extract! user, :id, :username, :fullname, :user_type, :address, :created_at, :updated_at
json.url user_url(user, format: :json)
