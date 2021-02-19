# frozen_string_literal: true

module HotpepperApi
  extend ActiveSupport::Concern

  # 検索条件に合致するレストランを取得する、半角スペースで複数条件指定可能
  def search_restaurant(term, count = 100)
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

  # idが合致するレストランを取得する、カンマ区切りで複数選択可能
  def search_restaurant_by_id(id)
    return json_error_msg('idが不正です') if id.blank?

    api_params = {
      key: API_KEY,
      id: id,
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
    JSON.parse(response.body)['results']['shop']
  else
    json_error_msg("HTTP ERROR: code=#{response.code} message=#{response.message}")
  end
end

def json_error_msg(msg)
  { error: { message: msg } }
end
