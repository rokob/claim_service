unless @claim_results.nil?
  json.claims @claim_results do |claim|
    json.partial! 'claims/claim', claim: claim
  end
end

unless @submission_results.nil?
  json.submissions @submission_results do |submission|
    json.partial! 'submissions/submission', submission: submission
  end
end
