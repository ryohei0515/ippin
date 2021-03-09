# frozen_string_literal: true

class ShopFoodsController < ApplicationController
  def show
    @shop_food = ShopFood.find(params[:id])
    @reviews = @shop_food.reviews.page(params[:page]).per(PER_REVIEW)

    _shops(@shop_food.shop_id)
  end

  def index
    @form = ShopFoodSearchForm.new(search_params)

    # 対象のShopFoodの取得。初期表示時はエラー表示回避のため、検索処理を実行せず、空の配列を作成する。
    res = search_params[:food_id].nil? ? ShopFood.where('1=0') : @form.search

    @shop_foods = res.page(params[:page]).per(PER_FOOD)
    if @shop_foods.count.zero?
      flash.now[:danger] = '検索結果が見つかりません。他の検索条件でお試しください。' if search_params[:food_id].present?
      return
    end

    _shops(@shop_foods.pluck(:shop_id))
  end

  private

  def search_params
    params.permit(:food_id, :large_area, :middle_area)
  end

  # @shopsのデータを作成する。
  def _shops(shop_ids)
    api_result = search_shop_by_id(shop_ids)['shop']
    @shops = api_result.map { |r| [r['id'], r] }.to_h
  end
end
