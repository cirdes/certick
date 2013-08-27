json.array!(@certifieds) do |certified|
  json.extract! certified, :slug
  json.url certified_url(certified, format: :json)
end
