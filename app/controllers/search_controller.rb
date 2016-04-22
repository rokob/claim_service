class SearchController < ApplicationController
  before_action :require_internal_user

  PERMITTED_KEYS = %i{ insured_id provider_id status from to result_types }
  RESULT_TYPES = %w{ submission claim }

  def search
    query = search_params.select{|k,_| PERMITTED_KEYS.include? k}
    if query[:result_types].present?
      query[:result_types].select!{|k| RESULT_TYPES.include? k}
    else
      query[:result_types] = ['claim'] # claim is default search type
    end

    @submission_results, @claim_results = [], []
    if query[:result_types].include?('submission')
      @submisson_results = Submission.where(insured_id: query[:insured_id], provider_id: query[:provider_id])
    end

    if query[:result_types].include?('claim')
      @claim_results = Claim.where(insured_id: query[:insured_id], provider_id: query[:provider_id], status: query[:status])
      if query[:from] && query[:to]
        @claim_results = @claim_results.joins(:services).where(services: {date: query[:from]..query[:to]})
      elsif query[:from]
        @claim_results = @claim_results.joins(:services).where('services.date > ?', query[:from])
      elsif query[:to]
        @claim_results = @claim_results.joins(:services).where('services.date < ?', query[:to])
      end
    end
  end

  private
    def search_params
      params.require(:query).permit!
    end
end
