class CreateRatings < ActiveRecord::Migration[8.0]
  def change
    create_table :ratings do |t|
      t.references :project, null: false, foreign_key: true
      t.integer :expert_id
      t.string :value

      t.timestamps
    end
  end
end
