json.(@claim, :insured_id, :provider_id, :status)

json.services @claim.services do |service|
  json.code
  json.cost
  json.date
end
