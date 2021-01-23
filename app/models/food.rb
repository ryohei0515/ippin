class Food < ApplicationRecord
  has_many :reviews
  has_many :users, through: :reviews
  default_scope -> { order(rate: :desc, name: :asc) }

  validates :name, presence: true, length: { maximum: 30 },
                   uniqueness: { scope: :restaurant, case_sensitive: false }
  validates :category, presence: true, length: { maximum: 15 }
  validates :restaurant, presence: true, length: { maximum: 50 }

  # 紐づくレビューの評価点数の平均を算出し、Foodモデルのrateに保持する。
  # DBに登録されていれば更新する。算出不可であればfalse。
  def calc_and_save_rate
    return false if self.reviews.count == 0
    self.rate = self.reviews.average(:rate).round(2)
    self.save!
  end
end
