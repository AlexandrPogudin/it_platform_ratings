class ChangeProjectToQuestionInRatings < ActiveRecord::Migration[8.0]
  def change
    remove_reference :ratings, :project, foreign_key: true
    add_reference :ratings, :question, null: false, foreign_key: true
  end
end

