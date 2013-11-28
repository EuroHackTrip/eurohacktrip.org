json.array!(@pages) do |page|
  json.extract! page, :name, :body, :show_in_nav
  json.url page_url(page, format: :json)
end
