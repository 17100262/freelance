class AdminPanelController < ApplicationController
  before_action :authenticate_user
  
  def index
    @res_count = Reservation.all.group(:status).count(:status)
    @jobs_count = Job.all.group(:status).count(:status)
  end
  
  def jobs
    if params[:status].present?
      @jobs = Job.where(status: params[:status])
      @status = params[:status]
    else
      @jobs = Job.where(status: "PENDING")
      @status = "PENDING"
    end
    @count = Job.group(:status).count(:status)
  end

  def reservations
    if params[:status].present?
      @reservations = Reservation.where(status: params[:status])
      @status = params[:status]
    else
      @reservations = Reservation.where(status: "PENDING")
      @status = "PENDING"
    end
    @count = Reservation.all.group(:status).count(:status)
  end

  def payments
  end

  private
    def authenticate_user
      if !user_signed_in? or !current_user.is_admin?
        redirect_back(fallback_location: root_url, alert: "You are not authorized to view this page")
      end
    end
end
