module ApplicationHelper
  def error_occurred?(input)
    if input.is_a?(Hash) && input[:error].present?
      flash[:error] = "An error occurred: #{input}"
    elsif !input.present?
      flash[:error] = "No policy found with the criteria:#{params[:policy_query]}"
    else
      false
    end
  end

  def devise_mapping
    Devise.mappings[:user]
  end

  def resource_name
    devise_mapping.name
  end

  def popup_login_form
    unless user_signed_in?
      respond_to do |format|
        format.js { render "devise/sessions/new" }
      end
    end
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
