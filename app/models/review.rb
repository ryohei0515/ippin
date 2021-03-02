# frozen_string_literal: true

class Review < ApplicationRecord
  belongs_to :user
  belongs_to :shop_food
  default_scope -> { order(created_at: :desc) }
  mount_uploader :picture, PictureUploader

  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 400 }
  validates :title, presence: true, length: { maximum: 50 }
  validates :rate, numericality: { greater_than_or_equal_to: 1,
                                   less_than_or_equal_to: 5 }
  validates :shop_food_id, presence: true
  has_many :likes, dependent: :destroy
end
