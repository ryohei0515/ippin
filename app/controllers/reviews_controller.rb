# frozen_string_literal: true

class ReviewsController < ApplicationController
  before_action :logged_in_user, only: %i[new create destroy edit update]
  before_action :correct_user, only: %i[destroy edit update]

  def new
    @form = ReviewForm.new
  end

  def create
    @form = ReviewForm.new(reviews_params)
    if @form.create
      flash[:success] = 'レビューを投稿しました'
      redirect_to review_path(@form.review_id)
    else
      render 'new'
    end
  end

  def show
    @review = Review.find(params[:id])
  end

  def edit
    @review = Review.find(params[:id])
    @form = ReviewForm.new(review: @review)
  end

  def update
    @review = Review.find(params[:id])
    @form = ReviewForm.new(reviews_params, review: @review)
    if @form.update
      flash[:success] = 'レビューを更新しました'
      redirect_to @review
    else
      render 'edit'
    end
  end

  def destroy
    review = Review.find(params[:id])
    review.destroy
    flash[:success] = 'レビューを削除しました'
    redirect_to user_path(@review_user)
  end

  private

  def reviews_params
    params.require(:review).permit(:content, :food_id, :food, :title, :shop,
                                   :rate, :user_id, :category, :picture, :picture_cache)
  end

  def correct_user
    @review_user = Review.find(params[:id]).user
    redirect_to(review_path(params[:id])) unless current_user?(@review_user)
  end
end
