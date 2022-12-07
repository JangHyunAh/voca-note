class Question < ApplicationRecord
  belongs_to :user, optional: true
  has_many :q_tags, dependent: :destroy
  has_many :tags, through: :q_tags
  has_one_attached :image
  has_many :q_similars, dependent: :destroy
  has_many :question_lists, dependent: :destroy
  has_many :lists, through: :question_lists
  
  accepts_nested_attributes_for :q_similars, allow_destroy: true
  accepts_nested_attributes_for :q_tags, allow_destroy: true

  validates :title, presence: true
  validates :mean, presence: true

  def display_image
    image.variant(resize_to_limit: [100,100])
  end
end
