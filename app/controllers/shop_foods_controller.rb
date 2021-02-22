# frozen_string_literal: true

class ShopFoodsController < ApplicationController
  def show
    @shop_food = ShopFood.find(params[:id])
    @reviews = @shop_food.reviews.page(params[:page]).per(PER_REVIEW)
    @shop = search_shop_by_id(@shop_food.shop)['shop'][0]
  end
end
