# frozen_string_literal: true

class Food < ApplicationRecord
  has_many :shop_foods

  validates :name, presence: true, length: { maximum: 30 },
                   uniqueness: { case_sensitive: false }
  validates :name_kana, length: { maximum: 50 }
  validates :category, presence: true, length: { maximum: 30 }
  validates :description, length: { maximum: 200 }
end
