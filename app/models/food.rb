# frozen_string_literal: true

class Food < ApplicationRecord
  has_many :shop_foods

  validates :name, presence: true, length: { maximum: 30 },
                   uniqueness: { case_sensitive: false }
end
