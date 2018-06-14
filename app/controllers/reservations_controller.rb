require 'paypal-sdk-rest'
include PayPal::SDK::REST
class ReservationsController < ApplicationController
  before_action :set_reservation, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  # GET /reservations
  # GET /reservations.json
  
  def index
    @reservations = Reservation.all
  end

  # GET /reservations/1
  # GET /reservations/1.json
  def show
  end

  # GET /reservations/new
  def new
    @reservation = Reservation.new
  end

  # GET /reservations/1/edit
  def edit
  end

  # POST /reservations
  # POST /reservations.json
  def create
    if current_user.check_reservations
      return redirect_back(fallback_location: root_url,alert: "You already have #{Variable.find_by_name("MAX_RESERVATIONS").value} reservations in progress. Please deliver one of these first to make more reservations.")
    else
      @reservation = Reservation.new(reservation_params)
      ending_time = (@reservation.job.duration / Variable.find_by_name("RESERVATION_FACTOR").value.to_f)*24*60*60
      @reservation.ending_time = Time.now + ending_time
      @reservation.status = "LIVE"
      job = @reservation.job
      @reservation.amount = @reservation.job.amount
      respond_to do |format|
        if @reservation.save
          @reservation.job.update(status: "RESERVED")
          TimerJob.set(wait_until: @reservation.ending_time).perform_later(@reservation,"LIVE")
          format.html { redirect_to @reservation, notice: "Job reserved successfully." }
          format.json { render :show, status: :created, location: @reservation }
        else
          format.html { render :new }
          format.json { render json: @reservation.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # PATCH/PUT /reservations/1
  # PATCH/PUT /reservations/1.json
  def update
    respond_to do |format|
      if @reservation.update(reservation_params)
        if params[:reservation][:status] == "LIVE"
          # TimerJob.set(wait_until: @reservation.ending_time).perform_later(@reservation,"LIVE")
        elsif params[:reservation][:status] == "DELIVERED"
          Notif.create(event: "<a href='#{reservation_url(@reservation.slug)}'>Worker has delivered the work of a reservation.</a>",user_id: @reservation.job.user.id)
        elsif params[:reservation][:status] == "INREVISION"
          Notif.create(event: "<a href='#{reservation_url(@reservation.slug)}'>Employer asked for a Revision.</a>",user_id: @reservation.user.id)
        elsif params[:reservation][:status] == "COMPLETED"
          PayoutJob.perform_later(@reservation,"COMPLETED")
          
        elsif params[:reservation][:status] == "REJECTED"
          PayoutJob.perform_later(@reservation,"REJECTED")
        end
        format.html { redirect_to @reservation, notice: 'Reservation was successfully updated.' }
        format.json { render :show, status: :ok, location: @reservation }
      else
        format.html { render :edit }
        format.json { render json: @reservation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reservations/1
  # DELETE /reservations/1.json
  def destroy
    @reservation.destroy
    respond_to do |format|
      format.html { redirect_to reservations_url, notice: 'Reservation was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_reservation
      @reservation = Reservation.friendly.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def reservation_params
      params.require(:reservation).permit(:user_id, :job_id, :status,:review,:rating,:amount,:ending_time,:slug,:revision_description,:rejection_description,:pause_reason,:paused_at,:reviewed_at)
    end
end
