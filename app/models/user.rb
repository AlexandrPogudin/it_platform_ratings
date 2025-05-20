class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :first_name, :last_name, :email, :role, presence: true
  validates :email, uniqueness: true
  validates :role, inclusion: { in: %w[creator expert] }

  has_many :created_projects, class_name: "Project", foreign_key: "creator_id"
  has_many :ratings_given, class_name: "Rating", foreign_key: "expert_id", dependent: :destroy

  def full_name
    [last_name, first_name, middle_name].compact.join(' ')
  end
end