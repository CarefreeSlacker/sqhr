json.array!(@histories) do |history|
  json.extract! history, :id, :user_id, :type, :attribute_name, :old_value, :new_value, :date
  json.url history_url(history, format: :json)
end
