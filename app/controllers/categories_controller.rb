class CategoriesController < ApplicationController
  before_action :logged_in_user     
  before_action :correct_user, only: [:new, :create, :show, :edit, :update, :destroy]    
  before_action :set_category, only: %i[ show edit update destroy ]

  # GET /categories or /categories.json
  def index
    if current_user.type_of == "employer"
      @categories = Category.all
      @category = Category.new
    else
      redirect_to root_url
    end
  end

  # GET /categories/1 or /categories/1.json
  def show
  end

  # GET /categories/new
  def new
    @category = Category.new
    
  end

  # GET /categories/1/edit
  def edit
    
  end

  # POST /categories or /categories.json
  def create

    @category = Category.new(category_params)
    respond_to do |format|
      if @category.save
        format.html { redirect_to categories_path, notice: t('categories.index.successful_save') }
        format.json { render :show, status: :created, location: @category }
      else
        if params[:category][:category_name] == ""
          format.html { redirect_to categories_path, notice: t('categories.index.empty_value') }
        else 
          format.html { redirect_to categories_path, notice: "#{t('categories.index.duplicate_value')} \"#{params[:category][:category_name]}\"" }
        end
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /categories/1 or /categories/1.json
  def update
    respond_to do |format|
      if @category.update(category_params)
        format.html { redirect_to @category, notice: "Category was successfully updated." }
        format.json { render :show, status: :ok, location: @category }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /categories/1 or /categories/1.json
  def destroy
    @category.destroy
    respond_to do |format|
      format.html { redirect_to categories_url, notice: "Category was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_category
      @category = Category.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def category_params
      params.require(:category).permit(:category_name)
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
        redirect_to jobs_path, notice: t('jobs.controller.not_authorized') if @job.nil?
      end
    end    
end
