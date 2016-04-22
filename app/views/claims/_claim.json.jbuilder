json.(claim, :insured_id, :provider_id, :status)

json.services claim.services do |service|
  json.(service, :code, :cost, :date)
end
