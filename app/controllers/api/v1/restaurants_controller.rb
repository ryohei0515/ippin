# frozen_string_literal: true

module Api
  module V1
    class RestaurantsController < ApiController
      # HOTPEPPERのAPIよりレストラン情報を取得する
      def index
        render json: { results: { error: { message: 'paramが不正です' } } } and return if params[:term].nil?

        api_params = {
          key: Rails.application.credentials.api_key[:HOTPEPPER],
          keyword: params[:term],
          format: 'json',
          count: '100'
        }
        uri = URI.parse("http://webservice.recruit.co.jp/hotpepper/gourmet/v1/?#{api_params.to_query}")
        response = Net::HTTP.start(uri.host, uri.port) do |http|
          http.get(uri.request_uri)
        end
        render json: JSON.parse(response.body)
      end
    end
  end
end
