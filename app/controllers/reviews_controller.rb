class ReviewsController < ApplicationController
  before_action :logged_in_user, only: [:new, :create, :destroy, :update]

  def new
    @review = current_user.reviews.new
  end

  def create
    @review = current_user.reviews.build(reviews_params)
    if @review.save
      flash[:success] = "レビューを投稿しました"
      redirect_to root_url
    else
      render 'new'
    end
  end

  def update

  end

  def destroy

  end

  private
    def reviews_params
      params.require(:review).permit(:content, :food)
    end
end
