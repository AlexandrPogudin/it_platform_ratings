class Comment < ApplicationRecord
  belongs_to :project
  belongs_to :user

  validates :content, presence: true
  validates :user_id, uniqueness: { scope: :project_id } 
end
