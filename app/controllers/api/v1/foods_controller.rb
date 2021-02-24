# frozen_string_literal: true

module Api
  module V1
    class FoodsController < ApiController
      def index
        food = Food.all
        render json: food
      end
    end
  end
end
