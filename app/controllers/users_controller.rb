# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :logged_in_user, only: %i[edit update]
  before_action :correct_user, only: %i[edit update]

  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
    @reviews = @user.reviews.page(params[:page]).per(PER_REVIEW)
    ids = []
    @reviews.each do |review|
      ids << review.shop.id
    end
    @shops = get_shop_info(ids) if @reviews.count.positive?
  end

  def create
    @user = User.new(users_params)
    if @user.save
      log_in @user
      flash[:success] = '登録が完了しました'
      redirect_to @user
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if params[:id] == Settings.sample_user.id.to_s
      flash.now[:danger] = 'ゲストユーザでログイン中のため、ユーザ情報の更新は実施できません。'
      render 'edit'
    elsif @user.update(users_params)
      flash[:success] = 'ユーザ情報を更新しました'
      redirect_to edit_user_path(@user)
    else
      render 'edit'
    end
  end

  private

  def users_params
    params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation, :picture, :picture_cache)
  end

  # 正しいユーザか確認
  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless current_user?(@user)
  end

  # @shopsのデータを作成する。
  def _shops(shop_ids)
    api_result = search_shop_by_id(shop_ids)['shop']
    api_result.map { |r| [r['id'], r] }.to_h
  end
end
