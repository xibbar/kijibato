json.array!(@users) do |user|
  json.extract! user, :id, :group_id, :name, :email
  json.url user_url(user, format: :json)
end
