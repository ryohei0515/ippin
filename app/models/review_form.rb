# frozen_string_literal: true

class ReviewForm
  include ActiveModel::Model
  extend CarrierWave::Mount
  attr_accessor :review_id, :user_id, :food_id, :food, :content, :title, :shop,
                :rate, :category

  mount_uploader :picture, PictureUploader

  validates :user_id, presence: true
  validates :food_id, presence: true
  # validates :food, presence: true, length: { maximum: 30 }
  validates :content, presence: true, length: { maximum: 400 }
  validates :title, presence: true, length: { maximum: 50 }
  validates :shop, presence: true, length: { maximum: 50 }
  validates :rate, numericality: { greater_than_or_equal_to: 1,
                                   less_than_or_equal_to: 5 }
  validates :category, presence: true, length: { maximum: 15 }

  delegate :persisted?, to: :review

  def initialize(attributes = nil, review: Review.new)
    @review = review
    attributes ||= default_attributes
    super(attributes)
  end

  def to_model
    review
  end

  def create
    return if invalid?

    ActiveRecord::Base.transaction do
      _review_food
      review = Review.create!(user_id: user_id, shop_food: @review_food,
                              content: content, title: title,
                              rate: rate, picture: picture)

      @review_food.calc_and_save_rate
      @review_id = review.id
    end
  rescue ActiveRecord::RecordInvalid => e
    p e
    false
  end

  def update
    return if invalid?

    ActiveRecord::Base.transaction do
      _review_food
      review.update(user_id: user_id, shop_food: @review_food,
                    content: content, title: title,
                    rate: rate, picture: picture)
      @review_food.calc_and_save_rate
    end
  rescue ActiveRecord::RecordInvalid
    p e
    false
  end

  private

  attr_reader :review
  attr_accessor :review_food

  # rubocop:disable Metrics/AbcSize
  def default_attributes
    {
      review_id: review.id,
      user_id: review.user_id,
      food_id: review.shop_food_id ? review.shop_food.food_id : nil,
      food: 'food',
      content: review.content,
      title: review.title,
      shop: review.shop_food_id ? review.shop_food.shop : nil,
      rate: review.rate,
      category: review.shop_food_id ? review.shop_food.food.category : nil,
      picture: review.picture
    }
  end
  # rubocop:enable Metrics/AbcSize

  # 主キーに合致するShopFoodがあればそれを返す。なければ作成する。
  def _review_food
    f = Food.find(food_id)
    @review_food = ShopFood.find_by(food: f, shop: shop)
    @review_food ||= ShopFood.create!(food: f, shop: shop)
  end
end
