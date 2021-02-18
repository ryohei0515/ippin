# frozen_string_literal: true

module Api
  module V1
    class RestaurantsController < ApiController
      include HotpepperApi
      # HOTPEPPERのAPIより、検索条件に該当するレストラン情報を取得する。
      def index
        r = search_restaurant(params[:term])
        render json: r
      end

      # HOTPEPPERのAPIより、IDに合致するレストラン情報を取得する。
      def show
        r = search_restaurant_by_id(params[:id])
        render json: r
      end
    end
  end
end
