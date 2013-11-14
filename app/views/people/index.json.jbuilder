json.array!(@people) do |person|
  json.extract! person, :name, :online_profile_link, :photo, :occupation, :country_id
  json.url person_url(person, format: :json)
end
