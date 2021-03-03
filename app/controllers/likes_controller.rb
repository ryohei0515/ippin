# frozen_string_literal: true

class LikesController < ApplicationController
  before_action :logged_in_user

  def create
    @review = Review.find(params[:review_id])
    current_user.like(@review)
    respond_to do |format|
      format.html { redirect_to @review }
      format.js
    end
  end

  def destroy
    @review = Like.find(params[:id]).review
    current_user.unlike(@review)
    respond_to do |format|
      format.html { redirect_to @review }
      format.js
    end
  end
end
