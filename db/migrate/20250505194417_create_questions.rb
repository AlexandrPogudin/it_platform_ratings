class CreateQuestions < ActiveRecord::Migration[8.0]
  def change
    create_table :questions do |t|
      t.references :project, null: false, foreign_key: true
      t.string :question

      t.timestamps
    end
  end
end
