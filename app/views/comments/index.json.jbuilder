json.array!(@comments) do |comment|
  json.extract! comment, :commenter, :email, :website, :content, :approved, :post_id
  json.url comment_url(comment, format: :json)
end
