# frozen_string_literal: true

class StaticPagesController < ApplicationController
  def home
    @foods = Food.all.page(params[:page]).per(PER_FOOD)
  end

  def help; end

  def about; end
end
