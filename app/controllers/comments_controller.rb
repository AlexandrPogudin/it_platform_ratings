class CommentsController < ApplicationController
    before_action :set_project
    before_action :set_comment, only: [:edit, :update, :destroy]
  
    def create
      @comment = @project.comments.find_or_initialize_by(user: current_user)
      @comment.content = params[:comment][:content]
  
      if @comment.save
        redirect_to project_path(@project), notice: "Комментарий сохранён."
      else
        redirect_to project_path(@project), alert: "Ошибка: комментарий не сохранён."
      end
    end
  
    def edit; end
  
    def update
      if @comment.update(content: params[:comment][:content])
        redirect_to project_path(@project), notice: "Комментарий обновлён."
      else
        render :edit
      end
    end
  
    def destroy
      @comment.destroy
      redirect_to project_path(@project), notice: "Комментарий удалён."
    end
  
    private
  
    def set_project
      @project = Project.find(params[:project_id])
    end
  
    def set_comment
      @comment = @project.comments.find_by!(user_id: current_user.id)
    end
  end
  
