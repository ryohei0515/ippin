# frozen_string_literal: true

class StaticPagesController < ApplicationController
  def home
    @foods = Food.all.page(params[:page]).per(PER_FOOD)
    return if @foods.empty?

    # 料理に紐付く店舗情報取得
    param = @foods.pluck(:shop).join(',')
    result = search_shop_by_id(param)['shop']
    @shops = result.map { |r| [r['id'], r] }.to_h
  end

  def help; end

  def about; end

  def shops; end
end
