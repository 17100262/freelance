class JobsController < ApplicationController
  before_action :set_job, only: [:show, :edit, :update, :destroy,:express,:payment,:confirm_payment]
  # before_action :authenticate_user!
  # GET /jobs
  # GET /jobs.json

  # GET /jobs/1
  # GET /jobs/1.json
  def express
    response = EXPRESS_GATEWAY.setup_purchase(@job.amount_in_cents,
      :ip                => request.remote_ip,
      :return_url        => payment_job_url(@job),
      :cancel_return_url => root_url,
      :no_shipping => true
    )
    redirect_to EXPRESS_GATEWAY.redirect_url_for(response.token)
  end
  def payment
    @express_token = params[:token]
  end
  def confirm_payment
    response = @job.purchase(params[:express_token],request.remote_ip)
    if response.success?
      @job.update(status: "LIVE")
      redirect_to @job,notice: "Payment Successfull"
    else
      redirect_to @job,alert: "#{response.message}"
    end
  end
  def show
    @blocked =  []
    @job.blocked_users.each do |job|
      @blocked << job.user.id
    end
  end

  # GET /jobs/new
  def new
    @job = current_user.jobs_as_employer.new
  end

  # GET /jobs/1/edit
  def edit
  end

  # POST /jobs
  # POST /jobs.json
  def create
    @job = Job.new(job_params)

    respond_to do |format|
      if @job.save
        
        @job.blocked_users.create(user_id: current_user.id)
        format.html { redirect_to express_job_path(@job), notice: 'Job was successfully created.' }
        format.json { render :show, status: :created, location: @job }
      else
        format.html { render :new }
        format.json { render json: @job.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /jobs/1
  # PATCH/PUT /jobs/1.json
  def update
    respond_to do |format|
      if @job.update(job_params)
        format.html { redirect_back(fallback_location: @job, notice: 'Job was successfully updated.')}
        format.json { render :show, status: :ok, location: @job }
      else
        format.html { render :edit }
        format.json { render json: @job.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /jobs/1
  # DELETE /jobs/1.json
  def destroy
    @job.destroy
    respond_to do |format|
      format.html { redirect_to jobs_url, notice: 'Job was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_job
      @job = Job.friendly.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def job_params
      params.require(:job).permit(:status, :title, :description, :deliverables, :duration, :language, :amount, :online, :address, :user_id)
    end
    
 
end
