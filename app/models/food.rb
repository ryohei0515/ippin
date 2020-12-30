class Food < ApplicationRecord
  has_many :reviews
  has_many :users, through: :reviews

  validates :name, presence: true, length: { maximum: 30 }
  validates :category, length: { maximum: 15 }
  validates :restaurant, presence: true, length: { maximum: 50 }
end
