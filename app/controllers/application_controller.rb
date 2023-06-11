class ApplicationController < ActionController::Base
  helper_method :current_user
  helper_method :user_auth!
  helper_method :user_signed_in?

  def current_user
    @current_user ||= session[:user_id] && User.find_by(id: session[:user_id])
  end

  def user_auth!
    return unless current_user.blank?

    redirect_to users_new_sessions_path
  end

  def user_signed_in?
    return unless current_user.present?

    redirect_to root_path
  end
end
