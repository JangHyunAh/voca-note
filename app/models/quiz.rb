class Quiz < ApplicationRecord
  belongs_to :user
  has_many :lists, dependent: :destroy

  validates :score, presence: true
  validates :user, presence: true
end
