json.array!(@participations) do |participation|
  json.extract! participation, :id, :startup_id, :event_id
  json.url participation_url(participation, format: :json)
end
