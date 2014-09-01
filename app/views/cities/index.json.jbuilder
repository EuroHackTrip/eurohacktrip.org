json.array!(@cities) do |city|
  json.extract! city, :name, :description, :country_id
  json.url city_url(city, format: :json)
end
