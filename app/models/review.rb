class Review < ApplicationRecord
  belongs_to :user
  default_scope -> { order(created_at: :desc) }

  validates :user_id, presence: true
  validates :food, presence: true, length: { maximum: 50 }
  validates :content, presence: true, length: { maximum: 400 }
end
