# frozen_string_literal: true

module Api
  module V1
    class AreasController < ApiController
      def index
        render json: index_area
      end
    end
  end
end
