json.array!(@events) do |event|
  json.extract! event, :event_id, :country_id
  json.url event_url(event, format: :json)
end
