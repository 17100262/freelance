class ReservationsController < ApplicationController
  before_action :set_reservation, only: [:show, :edit, :update, :destroy,:express,:payment,:confirm_payment]
  before_action :authenticate_user!
  # GET /reservations
  # GET /reservations.json
  def express
    amount = (Variable.find_by_name("RESERVATION_FEE").value.to_f / 100) * @reservation.amount * 100
    response = EXPRESS_GATEWAY.setup_purchase(amount,
      :ip                => request.remote_ip,
      :return_url        => payment_reservation_url(@reservation),
      :cancel_return_url => root_url,
      :no_shipping => true
    )
    redirect_to EXPRESS_GATEWAY.redirect_url_for(response.token)
  end
  def payment
    @express_token = params[:token]
  end
  def confirm_payment
    response = @reservation.purchase(params[:express_token],request.remote_ip)
    if response.success?
      ending_time = (@reservation.job.duration / Variable.find_by_name("RESERVATION_FACTOR").value.to_f)*24*60*60
      @reservation.update(status: "LIVE",ending_time: Time.now + ending_time.seconds)
      @reservation.job.update(status: "RESERVED")
      TimerJob.set(wait_until: @reservation.ending_time).perform_later(@reservation,"LIVE")
      redirect_to @reservation,notice: "Payment Successfull"
    else
      redirect_to @reservation,alert: "#{response.message}"
    end
  end
  
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
    @reservation = Reservation.new(reservation_params)
    @reservation.amount = @reservation.job.amount
    respond_to do |format|
      if @reservation.save
        format.html { redirect_to express_reservation_path(@reservation) }
        format.json { render :show, status: :created, location: @reservation }
      else
        format.html { render :new }
        format.json { render json: @reservation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /reservations/1
  # PATCH/PUT /reservations/1.json
  def update
    respond_to do |format|
      if @reservation.update(reservation_params)
        if params[:reservation][:status] == "LIVE"
          TimerJob.set(wait_until: @reservation.ending_time).perform_later(@reservation,"LIVE")
        elsif params[:reservation][:status] == "COMPLETED"
          @reservation.user.increment!(:balance,@reservation.amount)
        elsif params[:reservation][:status] == "REJECTED"
          @reservation.job.user.increment!(:balance,@reservation.amount)
          @reservation.job.blocked_users.create(user_id: @reservation.user.id)
          @reservation.job.update(status: "LIVE")
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
      params.require(:reservation).permit(:user_id, :job_id, :status,:review,:rating,:amount,:ending_time,:slug,:revision_description,:rejection_description,:pause_reason,:paused_at)
    end
end
