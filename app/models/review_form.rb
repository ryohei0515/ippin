# frozen_string_literal: true

class ReviewForm
  include ActiveModel::Model
  attr_accessor :review_id, :user_id, :food, :content, :title, :restaurant,
                :rate, :category, :picture

  validates :user_id, presence: true
  validates :food, presence: true, length: { maximum: 30 }
  validates :content, presence: true, length: { maximum: 400 }
  validates :title, presence: true, length: { maximum: 50 }
  validates :restaurant, presence: true, length: { maximum: 50 }
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
      review = Review.create!(user_id: user_id, food: @review_food,
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
      review.update(user_id: user_id, food: @review_food,
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
      food: review.food_id ? review.food.name : nil,
      content: review.content,
      title: review.title,
      restaurant: review.food_id ? review.food.restaurant : nil,
      rate: review.rate,
      category: review.food_id ? review.food.category : nil,
      picture: review.picture
    }
  end
  # rubocop:enable Metrics/AbcSize

  # 主キーに合致するFoodがあればそれを返す。なければ作成する。
  def _review_food
    @review_food = Food.find_by(name: food, restaurant: restaurant)
    @review_food ||= Food.create!(name: food, category: category,
                                  restaurant: restaurant)
  end
end
