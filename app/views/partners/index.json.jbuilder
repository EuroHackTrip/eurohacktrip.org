json.array!(@partners) do |partner|
  json.extract! partner, :id, :name, :description, :link, :tier, :year
  json.url partner_url(partner, format: :json)
end
