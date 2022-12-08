class QuestionList < ApplicationRecord
  belongs_to :question
  belongs_to :list, dependent: :destroy
end
