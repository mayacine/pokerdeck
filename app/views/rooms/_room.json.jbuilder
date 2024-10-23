json.extract! room, :id, :name, :uuid, :shared_link, :status, :created_at, :updated_at
json.url room_url(room, format: :json)
