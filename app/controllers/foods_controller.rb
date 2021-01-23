# frozen_string_literal: true

class FoodsController < ApplicationController
  def show
    @food = Food.find(params[:id])
    @reviews = @food.reviews.page(params[:page]).per(PER_REVIEW)
  end
end
