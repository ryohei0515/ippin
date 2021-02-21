# frozen_string_literal: true

module Api
  module V1
    class ShopsController < ApiController
      # HOTPEPPERのAPIより、検索条件に該当する店舗情報を取得する。
      def index
        r = search_shop(params[:term])
        render json: r
      end

      # HOTPEPPERのAPIより、IDに合致する店舗情報を取得する。
      def show
        r = search_shop_by_id(params[:id])
        render json: r
      end
    end
  end
end
