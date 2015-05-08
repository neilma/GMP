class MongoDbController < ApplicationController
  include ApplicationHelper
  before_action :authenticate_user!

  respond_to :js, :html

  # def new
  #   issue_state_code_to_id if params[:policy_query][:issue_state].present?
  #   bind_instance_vars(params[:policy_query])
  #   @policy_search_result = search_pms_policies(
  #       ERB.new(File.read("#{Rails.root}/lib/templates/sql.erb")).result(binding).tap{|i| p i})
  #   @mongified_data = mongify(@policy_search_result)
  # end
  # def popup
  #   @mongified_data = params[:mongified_data][:data]
  #
  #   respond_to do |format|
  #     format.js { render "mongo_db/new" }
  #   end
  # end

  def authenticate_user!
    if user_signed_in?
      # p session.delete('warden.user.user.key')
      p 11111111111111
      p current_user
      upload
    else
      popup_login_form
    end
  end

  def upload
    client = MongoDbClient.new
    JSON.parse(params[:mongified_data][:data]).each { |data| data["lob"] = params[:mongified_data][:lob]; client.upsert(data, params[:mongified_data][:collection]) }
    respond_to do |format|
      format.js { render "application/upload_to_mongodb" }
    end
  end

  def bind_instance_vars(hash)
    hash.each { |key, value| instance_variable_set("@#{key}", value) }
  end

  def issue_state_code_to_id
    params[:policy_query][:issue_state] = IssueState.find_by_state_code(params[:policy_query][:issue_state]).state_id
  end
end