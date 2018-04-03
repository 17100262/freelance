class VariablesController < ApplicationController
  before_action :set_variable, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user
  # GET /variables
  # GET /variables.json
  def index
    @variables = Variable.dorder
  end

  # GET /variables/1
  # GET /variables/1.json
  def show
  end

  # GET /variables/new
  def new
    @variable = Variable.new
  end

  # GET /variables/1/edit
  def edit
  end

  # POST /variables
  # POST /variables.json
  def create
    @variable = Variable.new(variable_params)

    respond_to do |format|
      if @variable.save
        format.html { redirect_to variables_path, notice: 'Variable was successfully created.' }
        format.json { render :show, status: :created, location: @variable }
      else
        format.html { render :new }
        format.json { render json: @variable.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /variables/1
  # PATCH/PUT /variables/1.json
  def update
    respond_to do |format|
      if @variable.update(variable_params)
        format.html { redirect_to variables_path, notice: 'Variable was successfully updated.' }
        format.json { render :show, status: :ok, location: @variable }
      else
        format.html { render :edit }
        format.json { render json: @variable.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /variables/1
  # DELETE /variables/1.json
  def destroy
    @variable.destroy
    respond_to do |format|
      format.html { redirect_to variables_url, notice: 'Variable was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_variable
      @variable = Variable.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def variable_params
      params.require(:variable).permit(:name, :value,:description)
    end
    
    def authenticate_user
      if !user_signed_in? or ( user_signed_in? and !current_user.is_admin? )
        redirect_back(fallback_location: root_url, alert: "You are not authorized to view this page")
      end
    end
    
end
