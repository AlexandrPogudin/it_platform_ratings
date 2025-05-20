class Rating < ApplicationRecord
  belongs_to :question
  belongs_to :expert, class_name: "User", foreign_key: "expert_id"

  validates :value, presence: true, inclusion: { in: 0..10 }
end
