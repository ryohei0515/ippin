# frozen_string_literal: true

module HotpepperApi
  extend ActiveSupport::Concern

  # 検索条件に合致する店舗を取得する、半角スペースで複数条件指定可能
  def search_shop(term, count = 100)
    return json_error_msg('ERROR: 条件指定が不正です') if term.blank?

    api_params = {
      key: API_KEY,
      keyword: term,
      format: FORMAT,
      count: count
    }
    uri = URI.parse(API_URL + api_params.to_query)
    api_access(uri)
  end

  # idが合致する店舗を取得する。IDの複数指定が可能。（最大20）
  def search_shop_by_id(*ids)
    return json_error_msg('idが不正です') if ids.blank?

    id_param = ids.join(',')
    api_params = {
      key: API_KEY,
      id: id_param,
      format: FORMAT
    }
    uri = URI.parse(API_URL + api_params.to_query)
    api_access(uri)
  end
end

private

API_KEY = Rails.application.credentials.api_key[:HOTPEPPER]
FORMAT = 'json'
API_URL = 'http://webservice.recruit.co.jp/hotpepper/gourmet/v1/?'

# httpでアクセスし、結果をJSON形式で返却する。
def api_access(uri)
  response = Net::HTTP.start(uri.host, uri.port) do |http|
    http.open_timeout = 5  # 接続時に待つ最大秒数
    http.get(uri.request_uri)
  end

  case response
  when Net::HTTPSuccess
    JSON.parse(response.body)['results']
  else
    json_error_msg("HTTP ERROR: code=#{response.code} message=#{response.message}")
  end
end

def json_error_msg(msg)
  { error: { message: msg } }
end
