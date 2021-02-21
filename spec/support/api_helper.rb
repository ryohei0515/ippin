# frozen_string_literal: true

module ApiHelper
  # idが合致する店舗情報を取得する
  def get_shop_info(id)
    api_params = {
      key: API_KEY,
      id: id,
      format: FORMAT
    }
    uri = URI.parse(API_URL + api_params.to_query)
    api_access(uri)
    response = Net::HTTP.start(uri.host, uri.port) do |http|
      http.open_timeout = 5  # 接続時に待つ最大秒数
      http.get(uri.request_uri)
    end

    case response
    when Net::HTTPSuccess
      JSON.parse(response.body)['results']['shop'][0]
    else
      "HTTP ERROR: code=#{response.code} message=#{response.message}"
    end
  end

  API_KEY = Rails.application.credentials.api_key[:HOTPEPPER]
  FORMAT = 'json'
  API_URL = 'http://webservice.recruit.co.jp/hotpepper/gourmet/v1/?'
end
