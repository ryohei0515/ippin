class ReviewsController < ApplicationController
  before_action :logged_in_user, only: [:new, :create, :destroy, :edit, :update]
  before_action :correct_user, only: [:destroy, :edit, :update]

  def new
    @review = current_user.reviews.new
  end

  def create
    @review = current_user.reviews.build(reviews_params)
    if @review.save
      flash[:success] = "レビューを投稿しました"
      redirect_to @review
    else
      render 'new'
    end
  end

  def show
    @review = Review.find(params[:id])
  end

  def edit
    @review = Review.find(params[:id])
  end

  def update
    @review = Review.find(params[:id])
    if @review.update(reviews_params)
      flash[:success] = "レビューを更新しました"
      redirect_to @review
    else
      render 'edit'
    end
  end

  def destroy
    review = Review.find(params[:id])
    review.destroy
    flash[:success] = "レビューを削除しました"
    redirect_to user_path(@review_user)
  end

  private
    def reviews_params
      params.require(:review).permit(:content, :food)
    end

    def correct_user
      @review_user = Review.find(params[:id]).user
      redirect_to(review_path(params[:id])) unless current_user?(@review_user)
    end
end
