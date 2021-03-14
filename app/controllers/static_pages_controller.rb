# frozen_string_literal: true

class StaticPagesController < ApplicationController
  def home
    @form = ShopFoodSearchForm.new(params.permit(:food_id, :large_area, :middle_area))
    res = ShopFood.where('1=0')
    @shop_foods = res.page(params[:page]).per(Settings.kaminari.per.shop_food)
  end

  def help; end

  def about; end

  def shops; end
end
