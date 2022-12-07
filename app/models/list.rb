class List < ApplicationRecord
  belongs_to :quiz, dependent: :destroy
  
  has_many :question_lists, dependent: :destroy
  has_many :questions, through: :question_lists
end
