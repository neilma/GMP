class PolicyQueryController < ApplicationController
  protect_from_forgery with: :null_session, if: Proc.new { |c| c.request.format == 'application/json' }
  include OracleToMongo
  include ApplicationHelper

  respond_to :js, :html

  def create
    issue_state_code_to_id if params[:policy_query][:issue_state].present?
    sub_schema
    bind_instance_vars(params[:policy_query])
    @policy_search_result = search_pms_policies(
        ERB.new(File.read("#{Rails.root}/lib/templates/sql_lite.erb")).result(binding).tap{|i| p i})
    unless error_occurred?(@policy_search_result)
    #   flash[:error] = "An error occurred: #{@policy_search_result}"
    # elsif !@policy_search_result.present?
    #   flash[:error] = "No policy found with the criteria:#{params[:policy_query]}"
    # else
      @mongified_data = mongify(@policy_search_result)
    end
  end

  def upload_to_mongodb
    client = MongoDbClient.new
    JSON.parse(params[:policy_query][:data]).each { |data| data["lob"] = params[:policy_query][:lob]; client.upsert(data) }
  end

  def bind_instance_vars(hash)
    hash.each { |key, value| instance_variable_set("@#{key}", value) }
  end

  def issue_state_code_to_id
    params[:policy_query][:issue_state] = IssueState.find_by_state_code(params[:policy_query][:issue_state]).state_id
  end

  def sub_schema
    params[:policy_query][:pms_schema] = { "STS1" => "PMS1DBA", "STST" => "PMSSDBA" }[params[:policy_query][:pms_schema]]
  end
end