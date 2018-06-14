class JobsController < ApplicationController
  before_action :set_job, only: [:show, :edit, :update, :destroy,:express,:payment,:confirm_payment]
  # before_action :authenticate_user!
  # GET /jobs
  # GET /jobs.json

  # GET /jobs/1
  # GET /jobs/1.json
  def express
    amount = Variable.find_by_name("CREATION_FEE").value* @job.amount
    response = EXPRESS_GATEWAY.setup_purchase(amount,
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
      Notif.create(event: "<a href='#{job_url(@job.slug)}'>Your Payment was successfull and your job is now live.</a>",user_id: @job.user.id)
      Notif.create(event: "<a href='#{job_url(@job.slug)}'>Job posted by #{@job.user.name} is now Live.</a>",user_id: User.admins.first.id)
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
    # if current_user.check_jobs
    #   return redirect_back(fallback_location: root_url,alert: "You cannot have more than #{Variable.find_by_name("MAX_JOBS").value} jobs LIVE simultaneously.")
    # else
      @job = current_user.jobs_as_employer.new
    # end
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
        format.html { redirect_to @job }
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
        if params[:order][:status] == "LIVE"
          Notif.create(event: "<a href='#{job_url(@job.slug)}'>Your Payment was successfull and your job is now live.</a>",user_id: @job.user.id)
        end
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
      format.html { redirect_back(fallback_location: jobs_url, notice: 'Job was successfully destroyed.') }
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
      params.require(:job).permit(:status, :title, :description,:document, :deliverables, :duration, :language, :amount, :online, :address, :user_id, :category_id,:subcategory_id)
    end
    
 
end
