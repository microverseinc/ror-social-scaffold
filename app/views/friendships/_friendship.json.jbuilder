json.extract! friendship, :id, :sender_id, :receiver_id, :status, :created_at, :updated_at
json.url friendship_url(friendship, format: :json)
