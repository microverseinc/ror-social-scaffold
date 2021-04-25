json.extract! friendship, :id, :user_id, :friendship_id, :status, :created_at, :updated_at
json.url friendship_url(friendship, format: :json)
