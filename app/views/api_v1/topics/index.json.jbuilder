json.result do
  json.array! @topics do |topic|
    json.partial! topic
  end
end