# frozen_string_literal: true

class StaticPagesController < ApplicationController
  def home
    @foods = Food.all.page(params[:page]).per(PER_FOOD)
    return if @foods.empty?

    # 料理に紐付くレストラン情報取得
    param = @foods.pluck(:restaurant).join(',')
    result = search_restaurant_by_id(param)['shop']
    @restaurants = result.map { |r| [r['id'], r] }.to_h
  end

  def help; end

  def about; end

  def restaurants; end
end
