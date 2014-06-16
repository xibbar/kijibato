json.array!(@groups) do |group|
  json.extract! group, :id, :initial, :name, :email
  json.url group_url(group, format: :json)
end
