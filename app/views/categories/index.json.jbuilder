json.array!(@categories) do |category|
  json.extract! category, :name, :description
  json.url category_url(category, format: :json)
end
