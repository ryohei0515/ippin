# frozen_string_literal: true

class ShopFoodsController < ApplicationController
  def show
    @shop_food = ShopFood.find(params[:id])
    @reviews = @shop_food.reviews.page(params[:page]).per(PER_REVIEW)
    @shop = search_shop_by_id(@shop_food.shop_id)['shop'][0]
  end

  def index
    @form = ShopFoodSearchForm.new(search_params)

    # 対象のShopFoodの取得。初期表示時はエラー表示回避のため、検索処理を実行せず、空の配列を作成する。
    res = search_params[:food_id].nil? ? ShopFood.where('1=0') : @form.search

    @shop_foods = res.page(params[:page]).per(PER_FOOD)
    return if @shop_foods.count.zero?

    api_result = search_shop_by_id(@shop_foods.pluck(:shop_id))['shop']
    @shops = api_result.map { |r| [r['id'], r] }.to_h
  end

  private

  def search_params
    params.permit(:food_id, :large_area, :middle_area)
  end
end
