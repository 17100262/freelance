class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  
  def after_sign_in_path_for(resource)
    stored_location_for(resource) ||
      if resource.is_admin?
        admin_panel_path
      else
        user_panel_path
      end
  end
  
  
  if Rails.env.production?
    rescue_from ActiveRecord::RecordNotFound do |exception|
      render_error 404
    end
  end
  
  def render_error(status)
    respond_to do |format|
      format.html { render 'layouts/error_' + status.to_s(), :status => status}
      format.all { render :nothing => true, :status => status }
    end
  end
  
  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username])
  end
  
  
end
