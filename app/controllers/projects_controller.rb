class ProjectsController < ApplicationController
  before_action :authenticate_user!
  before_action :require_creator!, except: [:index, :show, :archived] 

  def index
    if current_user.role == 'expert'
      @projects = Project.where(status: 'published')
    else
      status_filter = params[:status] 
      if status_filter.present?
        @projects = current_user.created_projects.where(status: status_filter)
      else
        @projects = current_user.created_projects
      end
    end
  end
  
  def archived
    @projects = current_user.created_projects.where(status: 'archived')
  end

  def new
    @project = Project.new
  end

  def create
    @project = current_user.created_projects.build(project_params)
    @project.status = 'draft'

    if @project.save
      redirect_to projects_path, notice: 'Проект успешно создан.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    if current_user.role == 'expert'
      @project = Project.find(params[:id])
    else
      @project = current_user.created_projects.find(params[:id])
    end
  end
  
  def edit
    @project = current_user.created_projects.find(params[:id])
  end
  
  def update
    @project = current_user.created_projects.find(params[:id])
    if @project.update(project_params)
      redirect_to project_path(@project), notice: "Проект обновлён."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @project = Project.find(params[:id])
    @project.destroy
    redirect_to projects_path, notice: 'Проект успешно удален.'
  end
  
  def submit_for_review
    @project = current_user.created_projects.find(params[:id])
    @project.update(status: 'published')
    redirect_to project_path(@project), notice: "Проект отправлен на оценку."
  end
  
  def publish
    project = current_user.created_projects.find(params[:id])
    project.update(status: 'published')
    redirect_to project_path(project), notice: "Проект опубликован."
  end
  
  def archive
    project = current_user.created_projects.find(params[:id])
    project.update(status: 'archived')
    redirect_to project_path(project), notice: "Проект архивирован."
  end
  
  def revert_to_draft
    project = current_user.created_projects.find(params[:id])
    project.update(status: 'draft')
    redirect_to project_path(project), notice: "Проект возвращён в подготовку."
  end  

  def delete_file
    @project = Project.find(params[:id])
    file = @project.files.find(params[:file_id])
    file.purge
    redirect_to edit_project_path(@project), notice: "Файл удален"
  end
   
  def upload_files
    @project = Project.find(params[:id])
    if params[:files]
      params[:files].each do |file|
        @project.files.attach(file)
      end
    end
    redirect_to edit_project_path(@project), notice: "Файлы загружены"
  end

  private

  def require_creator!
    redirect_to root_path, alert: 'Доступ запрещен.' unless current_user.role == 'creator'
  end

  def require_expert!
    redirect_to root_path, alert: 'Только для экспертов' unless current_user.role == 'expert'
  end

  def project_params
    params.require(:project).permit(:title, :description, :data_url, files: [])
  end  

end
