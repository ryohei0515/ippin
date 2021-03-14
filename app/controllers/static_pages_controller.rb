# frozen_string_literal: true

class StaticPagesController < ApplicationController
  def home
    @form = ShopFoodSearchForm.new(params.permit(:food_id, :large_area, :middle_area))

    @reviews = Review.all.page(params[:page]).per(Settings.kaminari.per.review)
    ids = []
    @reviews.each do |review|
      ids << review.shop.id
    end
    @shops = get_shop_info(ids) if @reviews.count.positive?
  end

  def help; end

  def about; end

  def shops; end
end
