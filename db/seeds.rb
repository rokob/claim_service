User.create(api_key: "abc123")
User.create(api_key: "abc123internal", internal: true)

insured_ids = [1, 42, 99]
provider_ids = [77, 101]

claim_1_services = [
  ["AB01",  7.20,  "2016-04-10T00:00:00-07:00"],
  ["AB12", 47.20,  "2016-04-20T01:08:09-07:00"],
  ["AB13", 407.20, "2016-04-20T01:08:09-07:00"],
  ["AB14", 33.33,  "2016-04-20T01:08:09-07:00"],
  ["AB15", 37.20,  "2016-04-20T01:08:09-07:00"]
]

claim_2_services = [
  ["AB11",  7.20,  "2016-04-15T00:00:00-07:00"],
  ["AB22", 47.20,  "2016-04-25T00:00:00-07:00"],
  ["AB13", 407.20, "2016-04-25T00:00:00-07:00"],
  ["AB14", 33.33,  "2016-04-25T00:00:00-07:00"],
  ["AB35", 37.20,  "2016-04-29T00:00:00-07:00"]
]

claim_3_services = [
  ["AB01",  9.20,  "2016-04-05T00:00:00-07:00"],
  ["AB23", 47.20,  "2016-04-15T01:08:09-07:00"],
  ["AB13", 407.40, "2016-04-15T01:08:09-07:00"],
  ["AB14", 66.33,  "2016-04-15T01:08:09-07:00"],
  ["AB35", 37.20,  "2016-04-19T01:08:09-07:00"]
]

claim_4_services = [
  ["AB21",  9.20,  "2016-04-15T00:00:00-07:00"],
  ["AB33", 27.20,  "2016-04-15T01:08:09-07:00"],
  ["AB43", 307.40, "2016-04-25T01:08:09-07:00"],
  ["AB44", 56.33,  "2016-04-15T01:08:09-07:00"],
  ["AB35", 37.20,  "2016-04-22T01:08:09-07:00"]
]

def self.services_to_json(services)
  result = []
  services.each do |code, cost, date|
    result << {code: code, cost: cost, date: date}
  end
  result.to_json
end

claim_1 = Claim.create(
  insured_id:  insured_ids[0],
  provider_id: provider_ids[0],
  status:      "created"
)

Submission.create(
  insured_id: claim_1.insured_id,
  provider_id: claim_1.provider_id,
  claim_id: claim_1.id,
  services: services_to_json(claim_1_services)
)

claim_2 = Claim.create(
  insured_id:  insured_ids[1],
  provider_id: provider_ids[0],
  status:      "processed"
)

Submission.create(
  insured_id: claim_2.insured_id,
  provider_id: claim_2.provider_id,
  claim_id: claim_2.id,
  services: services_to_json(claim_2_services)
)

claim_3 = Claim.create(
  insured_id:  insured_ids[2],
  provider_id: provider_ids[1],
  status:      "created"
)

Submission.create(
  insured_id: claim_3.insured_id,
  provider_id: claim_3.provider_id,
  claim_id: claim_3.id,
  services: services_to_json(claim_3_services)
)

claim_4 = Claim.create(
  insured_id:  insured_ids[2],
  provider_id: provider_ids[1],
  status:      "in_process"
)

Submission.create(
  insured_id: claim_4.insured_id,
  provider_id: claim_4.provider_id,
  claim_id: claim_4.id,
  services: services_to_json(claim_4_services)
)

[
  [claim_1.id, claim_1_services],
  [claim_2.id, claim_2_services],
  [claim_3.id, claim_3_services],
  [claim_4.id, claim_4_services]
].each do |id, services|
  services.each do |code, cost, date|
    Service.create(claim_id: id, code: code, cost: cost, date: date)
  end
end

