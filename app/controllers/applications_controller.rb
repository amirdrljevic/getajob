class ApplicationsController < ApplicationController
  before_action :logged_in_user  
  before_action :correct_user, only: [:show]
  before_action :set_application, only: %i[ show edit update destroy ]
  before_action :user_applicant, only: [:new, :create, :edit, :update]
  before_action :get_job

  # GET /applications or /applications.json
  def index
    #due to special route included, if there is no job_id in URL params, then display all applications made by certain user 
    if @job.nil?
      @applications = Application.where(user_id: current_user.id)
    else
      @applications = @job.applications
    end
  end

  # GET /applications/1 or /applications/1.json
  def show
  end

  # GET /applications/new
  def new
    @application = @job.applications.build
    @application.user = current_user
  end

  # GET /applications/1/edit
  def edit
  end

  # POST /applications or /applications.json
  def create
    @application = @job.applications.build(application_params)
    @application.user = current_user
    
    respond_to do |format|
      if @application.save
        format.html { redirect_to job_application_path(@job, @application), notice: t('applications.create.successfully_created') }
        format.json { render :show, status: :created, location: @application }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @application.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /applications/1 or /applications/1.json
  def update
    respond_to do |format|
      if @application.update(application_params)
        format.html { redirect_to job_application_path(@job), notice: "Application was successfully updated." }
        format.json { render :show, status: :ok, location: @application }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @application.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /applications/1 or /applications/1.json
  def destroy
    @application.destroy
    respond_to do |format|
      format.html { redirect_to job_applications_path(@job), notice: "Application was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_application
      @job = Job.find(params[:job_id])
      @application = @job.applications.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def application_params
      params.require(:application).permit(:user_id, :job_id, :cover_letter, :education, :telephone, :date_of_birth, :address)
    end

    def logged_in_user
      unless user_signed_in?
        respond_to do |format|
          format.html { redirect_to new_user_session_path, notice: t('global.controller.not_logged_in') }
          format.json { head :no_content }      
        end
      end    
    end       

    # Only user applicant can create, edit job applications
    def user_applicant
      if current_user.type_of != "applicant" 
        redirect_to root_url, notice: t('applications.controller.not_authorized')
      end
    end

    def get_job
      if(params[:job_id].present?)
        @job = Job.find(params[:job_id])
      end
    end 

    def correct_user
      @application = Application.find(params[:id])
      if current_user.id != @application.user_id
        redirect_to root_url, notice: t('applications.controller.not_authorized')
      end
    end
end
