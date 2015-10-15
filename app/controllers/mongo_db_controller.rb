class MongoDbController < ApplicationController
  include ApplicationHelper
  before_action :authenticate_user!

  respond_to :js, :html

  def authenticate_user!
    if user_signed_in?
      upload
    else
      popup_login_form
    end
  end

  def upload
    @client = MongoDbClient.new(collection: params[:mongified_data][:collection])
    db_cleaner
    JSON.parse(params[:mongified_data][:data]).each do |data|
      data["lob"] = params[:mongified_data][:lob]
      data["start"] = data["start"].to_time
      data["end"] = data["end"].to_time
      data["coverages"] = timify(data["coverages"])
      @client.upsert(data)
    end
    respond_to do |format|
      flash[:success] = "Mongo data uploaded successfully."
      format.js { render "application/upload_to_mongodb" }
    end
  end

  def timify(input)
    Array.wrap(input).each do |h|
      h["risk_start_date"] = h["risk_start_date"].to_time
      h["risk_end_date"] = h["risk_end_date"].to_time
    end
  end

  # Need to delete the existing record if matched, so PMS records can be inserted with a clean slate
  # This is required or the exsting subdocument won't get updated but appended.
  def db_cleaner
    JSON.parse(params[:mongified_data][:data]).each do |data|
      data["lob"] = params[:mongified_data][:lob]
      @client.destroy(data)
    end
  end

end