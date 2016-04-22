json.claims @claim_results do |claim|
  json.partial! 'claims/claim', claim: claim
end

json.submissions @submission_results do |submission|
  json.partial! 'submissions/submission', submission: submission
end
