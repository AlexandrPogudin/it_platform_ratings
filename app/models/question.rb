class Question < ApplicationRecord
  belongs_to :project

  has_many :ratings, dependent: :destroy
  validates :question, presence: true

  def average_rating
    return nil if ratings.empty?
    ratings.average(:value)&.round(2)
  end

  def average_rating_color
    return 'bg-secondary' if ratings.empty?
  
    avg = average_rating.to_f
    if avg <= 3
      'bg-danger'
    elsif avg <= 7
      'bg-warning text-dark'
    else
      'bg-success'
    end
  end
  
end
