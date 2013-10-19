json.array!(@projects) do |project|
  json.extract! project, :user_id, :name, :description, :lang
  json.url project_url(project, format: :json)
end
