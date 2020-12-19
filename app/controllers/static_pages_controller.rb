class StaticPagesController < ApplicationController
  def home
    @reviews = Review.all.page(params[:page]).per(PER_REVIEW)
  end

  def help
  end

  def about
  end
end
