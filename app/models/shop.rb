# frozen_string_literal: true

class Shop < ApplicationRecord
  has_many :shop_foods

  validates :id, presence: true
  validates :large_area, presence: true
  validates :middle_area, presence: true
end
