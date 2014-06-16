json.array!(@articles) do |article|
  json.extract! article, :id, :group_id, :user_id, :host, :ip, :user_agent, :title, :comment
  json.url article_url(article, format: :json)
end
