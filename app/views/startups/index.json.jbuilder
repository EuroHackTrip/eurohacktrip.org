json.array!(@startups) do |startup|
  json.extract! startup, :name, :logo, :city, :tagline, :description
  json.url startup_url(startup, format: :json)
end
