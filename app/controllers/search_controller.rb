class SearchController < ApplicationController
  before_action :require_internal_user

  PERMITTED_KEYS = %w{ insured_id provider_id status from to result_types }
  RESULT_TYPES = %w{ submission claim }
  SUBMISSION_QUERY_KEYS = %w{ insured_id provider_id }
  CLAIM_QUERY_KEYS = %w{ insured_id provider_id status }

  # The structure of the JSON query object was open ended so I made something
  # up. The search basically allows key/value pairs for exact matches,
  # allows a from/to field for searching service dates, and allows to
  # select whether you want submission, claim, or both model types returned.
  # I would have to understand better how this would be used to really
  # do something real here. Also, search is usually better handled by a
  # dedicated tool for search rather than piecing together arel.
  def search
    query = search_params.select{|k,_| PERMITTED_KEYS.include? k}
    if query['result_types'].present?
      query['result_types'].select!{|k| RESULT_TYPES.include? k}
    else
      query['result_types'] = ['claim'] # claim is default search type
    end

    @submission_results, @claim_results = nil, nil
    if query['result_types'].include?('submission')
      submission_query = query.select{|k,_| SUBMISSION_QUERY_KEYS.include? k}
      @submission_results = Submission.where(submission_query)
    end

    if query['result_types'].include?('claim')
      claim_query = query.select{|k,_| CLAIM_QUERY_KEYS.include? k}
      @claim_results = Claim.where(claim_query)
      if query['from'] && query['to']
        @claim_results = @claim_results.joins(:services).where(services: {date: query['from']..query['to']})
      elsif query['from']
        @claim_results = @claim_results.joins(:services).where('services.date > ?', query['from'])
      elsif query['to']
        @claim_results = @claim_results.joins(:services).where('services.date < ?', query['to'])
      end
      @claim_results = @claim_results.uniq
    end
  end

  private
    def search_params
      params.require(:query).permit!
    end
end
