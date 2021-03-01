# frozen_string_literal: true

class StaticPagesController < ApplicationController
  def home
    @shop_foods = ShopFood.all.page(params[:page]).per(PER_FOOD)
    return if @shop_foods.empty?

    # 料理に紐付く店舗情報取得
    param = @shop_foods.pluck(:shop_id).join(',')
    result = search_shop_by_id(param)['shop']
    @shops = result.map { |r| [r['id'], r] }.to_h
  end

  def help; end

  def about; end

  def shops; end
end
