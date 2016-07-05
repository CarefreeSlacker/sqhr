json.array!(@users) do |user|
  json.extract! user, :id, :first_name, :last_name, :department_id, :position_id, :salary, :fired, :hr_manager
  json.url user_url(user, format: :json)
end
