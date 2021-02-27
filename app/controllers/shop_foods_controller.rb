# frozen_string_literal: true

class ShopFoodsController < ApplicationController
  def show
    @shop_food = ShopFood.find(params[:id])
    @reviews = @shop_food.reviews.page(params[:page]).per(PER_REVIEW)
    @shop = search_shop_by_id(@shop_food.shop_id)['shop'][0]
  end

  def index
    @form = ShopFoodSearchForm.new(search_params)
    # 初期表示時以外は入力チェックを実施
    @form.invalid? unless search_params[:food_id].nil?

    @shop_foods = @form.search.page(params[:page]).per(PER_FOOD)
    return if @shop_foods.count.zero?

    api_result = search_shop_by_id(@shop_foods.pluck(:shop_id))['shop']
    @shops = api_result.map { |r| [r['id'], r] }.to_h
  end

  private

  def search_params
    params.permit(:food_id)
  end
end
