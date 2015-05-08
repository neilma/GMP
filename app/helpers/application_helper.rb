module ApplicationHelper
  def error_occurred?(input)
    if input.is_a?(Hash) && input[:error].present?
      flash[:error] = "An error occurred: #{input}"
    elsif !input.present?
      flash[:error] = "No policy found with the criteria:#{params[:policy_query]}"
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
end
