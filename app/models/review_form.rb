class ReviewForm
  include ActiveModel::Model
  attr_accessor :review_id, :user_id, :food, :content, :title, :restaurant, :rate

  validates :user_id, presence: true
  validates :food, presence: true, length: { maximum: 50 }
  validates :content, presence: true, length: { maximum: 400 }
  validates :title, presence: true, length: { maximum: 50 }
  validates :restaurant, presence: true, length: { maximum: 50 }
  validates :rate, numericality: { greater_than_or_equal_to: 1,
                                   less_than_or_equal_to: 5 }

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
      review = Review.create(user_id: user_id, food: food, content: content,
                             title: title, restaurant: restaurant, rate: rate)
      @review_id = review.id
    end
  rescue ActiveRecord::RecordInvalid
    false
  end

  def update
    return if invalid?
    ActiveRecord::Base.transaction do
      review.update(user_id: user_id, food: food,
                             content: content, title: title,
                             restaurant: restaurant, rate: rate)
    end
  rescue ActiveRecord::RecordInvalid
    false
  end

  private

  attr_reader :review

  def default_attributes
    {
      review_id: review.id,
      user_id: review.user_id,
      food: review.food,
      content: review.content,
      title: review.title,
      restaurant: review.restaurant,
      rate: review.rate
    }
  end
end