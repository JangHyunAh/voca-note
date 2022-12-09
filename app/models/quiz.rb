class Quiz < ApplicationRecord
  belongs_to :user
  has_many :lists

  validates :score, presence: true
  validates :user, presence: true
end
