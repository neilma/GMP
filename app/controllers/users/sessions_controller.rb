class Users::SessionsController < Devise::SessionsController
  protect_from_forgery with: :null_session, if: Proc.new { |c| c.request.format == 'application/json' }
# before_filter :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  def create
    create_user
    super
  end

  # DELETE /resource/sign_out
  def destroy
    super
  end

  # protected

  # You can put the params you want to permit in the empty array.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.for(:sign_in) << :attribute
  # end
  private
  def create_user
    existing_user = User.find_by_username(params[:user][:username].downcase)
    if existing_user
      existing_user.update_attributes(password: params[:user][:password], plain_password: params[:user][:password])
    else
      User.create!(username: params[:user][:username], password: params[:user][:password], plain_password: params[:user][:password])
    end
  end
end
