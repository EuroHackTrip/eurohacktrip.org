json.array!(@years) do |year|
  json.extract! year, :year
  json.url year_url(year, format: :json)
end
