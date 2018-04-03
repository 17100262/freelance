class UserPanelController < ApplicationController
  before_action :authenticate_user
  def index
  end

  def jobs_as_employer
    if params[:status].present?
      @jobs = current_user.jobs_as_employer.where(status: params[:status])
      @status = params[:status]
    else
      @jobs = current_user.jobs_as_employer.where(status: "PENDING")
      @status = "PENDING"
    end
    @count = current_user.jobs_as_employer.group(:status).count(:status)
  end
  

  def jobs_as_worker
    if params[:status].present?
      @jobs = current_user.jobs_as_worker.where(status: params[:status])
      @status = params[:status]
    else
      @jobs = current_user.jobs_as_worker.where(status: "RESERVED")
      @status = "RESERVED"
    end
    @count = current_user.jobs_as_worker.group(:status).count(:status)
  end
  
  def reservations_as_employer
     if params[:status].present?
      @reservations = current_user.reservations_as_employer.where(status: params[:status])
      @status = params[:status]
    else
      @reservations = current_user.reservations_as_employer.where(status: "PENDING")
      @status = "PENDING"
    end
    @count = current_user.reservations_as_employer.group(:status).count(:status)
  end
  
  def reservations_as_worker
    if params[:status].present?
      @reservations = current_user.reservations_as_worker.where(status: params[:status])
      @status = params[:status]
    else
      @reservations = current_user.reservations_as_worker.where(status: "PENDING")
      @status = "PENDING"
    end
    @count = current_user.reservations_as_worker.group(:status).count(:status)
  end
  
  def payments
  end
  
  private
    def authenticate_user
      if !user_signed_in? or current_user.is_admin?
        redirect_back(fallback_location: root_url, alert: "You are not authorized to view this page")
      end
    end
end
