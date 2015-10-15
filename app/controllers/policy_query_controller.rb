class PolicyQueryController < ApplicationController
  protect_from_forgery with: :null_session, if: Proc.new { |c| c.request.format == 'application/json' }
  include OracleToMongo
  include ApplicationHelper
  before_action :authenticate_user!

  respond_to :js, :html

  def authenticate_user!
    unless user_signed_in?
      popup_login_form
    end
  end

  def create
    issue_state_code_to_id if params[:policy_query][:issue_state].present?
    sub_schema
    bind_instance_vars(params[:policy_query])
    @policy_search_result = search_pms_policies(current_user.username, current_user.plain_password,
        ERB.new(File.read("#{Rails.root}/lib/templates/sql_lite.erb")).result(binding).tap{|i| p i})
    unless error_occurred?(@policy_search_result)
    #   flash[:error] = "An error occurred: #{@policy_search_result}"
    # elsif !@policy_search_result.present?
    #   flash[:error] = "No policy found with the criteria:#{params[:policy_query]}"
    # else
      @mongified_data = mongify(@policy_search_result)
    end
  end

end