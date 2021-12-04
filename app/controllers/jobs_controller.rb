class JobsController < ApplicationController
  before_action :logged_in_user  
  before_action :correct_user, only: [:new, :create, :edit, :update, :destroy]    
  before_action :set_job, only: %i[show edit update destroy ]

  # GET /jobs or /jobs.json
  def index
    @jobs = Job.where('valid_until >= ?', DateTime.now.to_date)
  end

  # GET /jobs/1 or /jobs/1.json
  def show
  end

  # GET /jobs/new
  def new
    @job = current_user.jobs.build
  end

  # GET /jobs/1/edit
  def edit
  end

  # POST /jobs or /jobs.json
  def create
    @job = current_user.jobs.build(job_params)

    respond_to do |format|
      if @job.save
        format.html { redirect_to @job, notice: "Job was successfully created." }
        format.json { render :show, status: :created, location: @job }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @job.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /jobs/1 or /jobs/1.json
  def update
    respond_to do |format|
      if @job.update(job_params)
        format.html { redirect_to @job, notice: "Job was successfully updated." }
        format.json { render :show, status: :ok, location: @job }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @job.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /jobs/1 or /jobs/1.json
  def destroy
    @job.destroy
    respond_to do |format|
      format.html { redirect_to jobs_url, notice: "Job was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_job
      @job = Job.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def job_params
      params.require(:job).permit(:title, :description, :category_id, :user_id, :valid_until)
    end

    def logged_in_user
      unless user_signed_in?
        respond_to do |format|
          format.html { redirect_to new_user_session_path, notice: t('global.controller.not_logged_in') }
          format.json { head :no_content }      
        end
      end    
    end         

    def correct_user
      # Only users of type 'employer' can create job posts
      if current_user.type_of != "employer"
        #@job = current_user.jobs.find_by(id: params[:id])
        redirect_to jobs_path, notice: t('jobs.controller.not_authorized') if @job.nil?
      end
    end
end
