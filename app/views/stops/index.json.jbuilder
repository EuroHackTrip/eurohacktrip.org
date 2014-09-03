json.array!(@stops) do |stop|
  json.extract! stop, :id, :name, :description, :year, :dates, :link
  json.url stop_url(stop, format: :json)
end
