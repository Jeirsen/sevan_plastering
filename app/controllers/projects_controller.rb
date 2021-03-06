class ProjectsController < ApplicationController
  before_action :set_project, only: [:show, :edit, :update, :destroy]

  # GET /projects
  # GET /projects.json
  def index
    @projects = Project.all
  end

  # GET /projects/1
  # GET /projects/1.json
  def show
  end

  # GET /projects/new
  def new
    @project = Project.new
    @builders = Builder.all
    render :layout => false
  end

  # GET /projects/1/edit
  def edit
    @builders = Builder.all
    render :layout => true
  end

  # POST /projects
  # POST /projects.json
  def create
    @project = Project.new(project_params)

    respond_to do |format|
      if @project.save
        format.html { redirect_to builder_path(@project.builder_id), notice: 'Project was successfully created.' }
        format.json { render :show, status: :created, location: @project }
      else
        format.html { render :new }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /projects/1
  # PATCH/PUT /projects/1.json
  def update
    respond_to do |format|
      if @project.update(project_params)
        format.html { redirect_to project_path, notice: 'Project was successfully updated.' }
        format.json { render :show, status: :ok, location: @project }
      else
        format.html { render :edit }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /projects/1
  # DELETE /projects/1.json
  def destroy
    @project.destroy
    respond_to do |format|
      format.html { redirect_to project_path, notice: 'Project was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def update_project
    if (params[:project][:name].blank? or params[:project][:id].blank?)
        response = {success: false, data: "Missing parameters"}
    else
      
      id = params[:project][:id]
      project = Project.where(id: id).first
      if (project.blank?)
        response = {success: false, data: "Project not found!"}
      else
        project.update(project_params)
        response = {success: true, data: "Project updated successfully!"}
      end
    end
    render json: response, status: 200
  end


  def remove_project
    if(params[:id].blank?)
      response = {success: false, data: "Missing parameters"}
    else
      project_id = params[:id]
      project = Project.where(id: project_id).first
      if project.nil?
        response = {success: false, data: "Project not found!"}
      else
        project.update_attributes(:status => Project::Status[:inactive])
        response = {success: true, data: "Project removed successfully!"}
      end
    end
    render json: response, status: 200
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_project
      @project = Project.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def project_params
      params.require(:project).permit(:name, :status, :builder_id)
    end
end
