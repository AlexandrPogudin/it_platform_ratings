class RatingsController < ApplicationController
  before_action :authenticate_user!
  before_action :require_expert!

  def create
    @project = Project.find(params[:project_id])
  
    # Сохраняем оценки
    params[:ratings].each do |question_id, value|
      question = @project.questions.find(question_id)
      rating = question.ratings.find_or_initialize_by(expert_id: current_user.id)
      rating.value = value
      rating.save!
    end
  
    # Пересчитываем средние баллы
    averages = @project.questions.map do |q|
      {
        question_id: q.id,
        average: q.average_rating,
        color: q.average_rating_color
      }
    end
  
    render json: { success: true, averages: averages }
  end
    
  
  private

  def require_expert!
    redirect_to root_path, alert: "Доступ только для экспертов" unless current_user.role == "expert"
  end
end
