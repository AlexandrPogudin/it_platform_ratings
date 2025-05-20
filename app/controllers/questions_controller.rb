class QuestionsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_project
    before_action :require_creator!
  
    def new
      @question = @project.questions.new
    end
  
    def create
      @question = @project.questions.new(question_params)
      if @question.save
        redirect_to project_path(@project), notice: 'Вопрос добавлен.'
      else
        render :new
      end
    end
  
    def edit
      @question = @project.questions.find(params[:id])
    end
  
    def update
      @question = @project.questions.find(params[:id])
      if @question.update(question_params)
        redirect_to project_path(@project), notice: 'Вопрос обновлён.'
      else
        render :edit
      end
    end
  
    def destroy
      @question = @project.questions.find(params[:id])
      @question.destroy
      redirect_to project_path(@project), notice: 'Вопрос удалён.'
    end
  
    private
  
    def set_project
      @project = current_user.created_projects.find(params[:project_id])
    end
  
    def question_params
      params.require(:question).permit(:question)
    end
  end
  
