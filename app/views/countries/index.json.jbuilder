json.array!(@countries) do |country|
  json.extract! country, :name, :description, :flag
  json.url country_url(country, format: :json)
end
