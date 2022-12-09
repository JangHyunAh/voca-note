class List < ApplicationRecord
  belongs_to :quiz
  
  has_many :question_lists
  has_many :questions, through: :question_lists
end
