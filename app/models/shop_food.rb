# frozen_string_literal: true

class ShopFood < ApplicationRecord
  has_many :reviews
  has_many :users, through: :reviews
  belongs_to :food
  default_scope -> { order(rate: :desc, name: :asc) }

  validates :food_id, presence: true
  validates :name, presence: true, length: { maximum: 30 },
                   uniqueness: { scope: :shop, case_sensitive: false }
  validates :category, presence: true, length: { maximum: 15 }
  validates :shop, presence: true, length: { maximum: 50 }

  # 紐づくレビューの評価点数の平均を算出し、ShopFoodモデルのrateに保持する。
  # DBに登録されていれば更新する。算出不可であればfalse。
  def calc_and_save_rate
    return false if reviews.count.zero?

    self.rate = reviews.average(:rate).round(2)
    save!
  end
end
