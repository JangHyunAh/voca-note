class Tag < ApplicationRecord
  has_many :q_tags, dependent: :destroy
  has_many :questions, through: :q_tags
  belongs_to :user, optional: true
  validates :name, uniqueness: true, presence: true
  
  def self.looks(search, word)
    p 111111111
    p search
    p word
    @title = Question.where("title LIKE?","%#{word}%")
  end

end
