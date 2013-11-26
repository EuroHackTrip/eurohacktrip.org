json.array!(@home_page_contents) do |home_page_content|
  json.extract! home_page_content, :content
  json.url home_page_content_url(home_page_content, format: :json)
end
