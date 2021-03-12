# frozen_string_literal: true

module HotpepperApi
  extend ActiveSupport::Concern

  # 検索条件に合致する店舗を取得する、半角スペースで複数条件指定可能
  def search_shop(term, count = Settings.hotpepper_api.search_shops_limit)
    return json_error_msg('ERROR: 条件指定が不正です') if term.blank?

    api_params = {
      key: API_KEY,
      keyword: term,
      format: FORMAT,
      count: count
    }
    uri = URI.parse(SHOP_API_URL + api_params.to_query)
    # complement_shop_info(api_access(uri))
    # ポートフォリオ用の仮店舗も検索できるよう修正。#56
    complement_shop_info(TemporaryShop.search(api_access(uri), term))
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
    uri = URI.parse(SHOP_API_URL + api_params.to_query)
    # complement_shop_info(api_access(uri))
    # ポートフォリオ用の仮店舗も検索できるよう修正。#56
    complement_shop_info(TemporaryShop.search_by_id(api_access(uri), ids))
  end

  # Areaの一覧を取得する。
  def index_area
    api_params = {
      key: API_KEY,
      format: FORMAT
    }
    uri = URI.parse(AREA_API_URL + api_params.to_query)
    api_access(uri)
  end

  # shop_idを元にHotpepperApiから店舗情報を取得しハッシュで返却する。（KEYはshop_id）
  def get_shop_info(shop_ids)
    api_result = search_shop_by_id(shop_ids)['shop']
    api_result.map { |r| [r['id'], r] }.to_h
  end
end

private

API_KEY = Rails.application.credentials.api_key[:HOTPEPPER]
FORMAT = 'json'
SHOP_API_URL = 'http://webservice.recruit.co.jp/hotpepper/gourmet/v1/?'
AREA_API_URL = 'http://webservice.recruit.co.jp/hotpepper/middle_area/v1/?'

# httpでアクセスし、結果をJSON形式で返却する。
def api_access(uri)
  response = Net::HTTP.start(uri.host, uri.port) do |http|
    http.open_timeout = 5 # 接続時に待つ最大秒数
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

HASH_KEYS = {
  'budget' => %w[average code name],
  'coupon_urls' => %w[pc sp],
  'genre' => %w[catch code name],
  'large_area' => %w[code name],
  'large_service_area' => %w[code name],
  'middle_area' => %w[code name],
  'photo' => %w[mobile pc],
  'service_area' => %w[code name],
  'small_area' => %w[code name],
  'sub_genre' => %w[code name],
  'urls' => %w[pc]
}.freeze

# 結果ハッシュの1階層目にキーがなく、2階層目以降のキーが取得できない場合、2階層目以降のキーを設定する。（値は空）
def complement_shop_info(hash)
  hash['shop'].each_with_index do |shop, i|
    HASH_KEYS.each do |key, array|
      hash['shop'][i][key] = array.map { |v| [v, ''] }.to_h if shop[key].nil?
    end
  end
  hash
end
