class ApplicationController < ActionController::Base
  protect_from_forgery prepend: true
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :check_paypal_email
  
  def check_paypal_email
    if user_signed_in?
      if !current_user.paypal_email.present?
        flash[:notice] = "Please add PayPal Email for Payouts/Refunds before you continue to use our services"
        redirect_to edit_user_path(current_user)
      end
    end
  end
  
  def after_sign_in_path_for(resource)
    if params[:redirect_to].present?
      store_location_for(resource, params[:redirect_to])	
    else
      stored_location_for(resource) ||
        if resource.is_admin?
          admin_panel_path
        else
          user_panel_path
        end
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
