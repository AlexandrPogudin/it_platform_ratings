class Project < ApplicationRecord
    belongs_to :creator, class_name: "User", foreign_key: "creator_id"
    has_many :ratings
    has_many :questions, dependent: :destroy
    has_many :comments, dependent: :destroy
    has_many_attached :files

    validates :title, :description, :data_url, :status, presence: true
  end
  