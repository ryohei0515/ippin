# frozen_string_literal: true

class ReviewForm
  include ActiveModel::Model
  include HotpepperApi
  extend CarrierWave::Mount
  attr_accessor :review_id, :user_id, :food_id, :content, :title, :shop_id,
                :rate

  mount_uploader :picture, PictureUploader

  validates :user_id, presence: true
  validates :food_id, presence: true
  validates :content, presence: true, length: { maximum: 400 }
  validates :title, presence: true, length: { maximum: 50 }
  validates :shop_id, presence: true
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
      @review_food = _review_food
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
      @review_food = _review_food
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
      content: review.content,
      title: review.title,
      shop_id: review.shop_food_id ? review.shop_food.shop_id : nil,
      rate: review.rate,
      picture: review.picture
    }
  end
  # rubocop:enable Metrics/AbcSize

  # 主キーに合致するShopFoodがあればそれを返す。なければ作成する。
  def _review_food
    shop = find_or_create_shop(shop_id)
    food = Food.find(food_id)
    ShopFood.find_by(food: food, shop: shop) || ShopFood.create!(food: food, shop: shop)
  end

  # 引数のidに該当するレコードがShop存在する場合はそれを返す。なければ作成する。
  def find_or_create_shop(id)
    shop = Shop.find_by_id(id)
    return shop unless shop.nil?

    # shopが見つからない場合、APIより情報を取得し登録する。
    shop_info = search_shop_by_id(id)['shop'][0]
    Shop.create!(id: id, large_area: shop_info['large_area']['code'], middle_area: shop_info['middle_area']['code'])
  end
end
