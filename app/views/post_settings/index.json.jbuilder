json.array!(@post_settings) do |post_setting|
  json.extract! post_setting, :posts_per_page, :allow_comments
  json.url post_setting_url(post_setting, format: :json)
end
