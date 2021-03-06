class TemporaryShop < ApplicationRecord

  # 検索条件に合致するTemporaryShopを取得し、その結果を引数のShopのハッシュに差し替えて返却する。
  def self.search(hash, term)
    return hash if hash['error'].present?

    hash['results_returned'] = hash['results_returned'].to_i # 処理用に数値に変換する。最後文字列に戻す。
    query = "%#{term.gsub(/ /, "%' AND search_keyword like '%")}%"
    shops = TemporaryShop.where("search_keyword like '#{query}'")
    hash['shop'] = [] if hash['results_returned'].zero?

    shops.each_with_index do |shop, i|
      hash_shop = convert_hash(shop)
      hash['results_available'] += 1

      if hash['results_returned'] < Settings.hotpepper_api.search_shops_limit
        hash['results_returned'] += 1
        hash['shop'].insert(i, hash_shop)
      else
        hash['shop'][i] = hash_shop
      end
    end

    hash['results_returned'] = hash['results_returned'].to_s
    return hash
  end

  # IDが合致するTemporaryShopを取得し、その結果を引数のShopのハッシュに追加して返却する。
  def self.search_by_id(hash, *ids)
    return hash if hash['error'].present?

    hash['results_returned'] = hash['results_returned'].to_i # 処理用に数値に変換する。最後文字列に戻す。
    query = "'#{ids.join(",").gsub(/,/, "','")}'"
    shops = TemporaryShop.where("id in (#{query})")
    hash['shop'] = [] if hash['results_returned'].zero?

    shops.each do |shop|
      hash_shop = convert_hash(shop)
      hash['results_available'] += 1
      hash['results_returned'] += 1
      hash['shop'] << hash_shop
    end

    hash['results_returned'] = hash['results_returned'].to_s
    return hash
  end

  # TemporaryShopを、HotpepperAPIと同じ形式のハッシュに変換する。
  def self.convert_hash(shop)
    {
      'access' => shop.access || '',
      'address' => shop.address || '',
      'band' => shop.band || '',
      'barrier_free' => shop.barrier_free || '',
      'budget' => {
        'average' => shop.budget_average || '',
        'code' => shop.budget_code || '',
        'name' => shop.budget_name || ''
      },
      'budget_memo' => shop.budget_memo || '',
      'capacity' => shop.capacity || 0,
      'card' => shop.card || '',
      'catch' => shop.catch || '',
      'charter' => shop.charter || '',
      'child' => shop.child || '',
      'close' => shop.close || '',
      'coupon_urls' => {
        'pc' => shop.coupon_urls_pc || '',
        'sp' => shop.coupon_urls_sp || ''
      },
      'course' => shop.course || '',
      'english' => shop.english || '',
      'equipment' => shop.equipment || '',
      'free_drink' => shop.free_drink || '',
      'free_food' => shop.free_food || '',
      'genre' => {
        'catch' => shop.genre_catch || '',
        'code' => shop.genre_code || '',
        'name' => shop.genre_name || ''
      },
      'horigotatsu' => shop.horigotatsu || '',
      'id' => shop.id || '',
      'karaoke' => shop.karaoke || '',
      'ktai_coupon' => shop.ktai_coupon || 0,
      'ktai' => shop.ktai || '',
      'large_area' => {
        'code' => shop.large_area_code || '',
        'name' => shop.large_area_name || ''
      },
      'large_service_area' => {
        'code' => shop.large_service_area_code || '',
        'name' => shop.large_service_area_name || ''
      },
      'lat' => shop.lat || 0,
      'lng' => shop.lng || 0,
      'logo_image' => shop.logo_image || '',
      'lunch' => shop.lunch || '',
      'middle_area' => {
        'code' => shop.middle_area_code || '',
        'name' => shop.middle_area_name || ''
      },
      'midnight' => shop.midnight || '',
      'mobile_access' => shop.mobile_access || '',
      'name' => shop.name || '',
      'name_kana' => shop.name_kana || '',
      'non_smoking' => shop.non_smoking || '',
      'open_air' => shop.open_air || '',
      'open' => shop.open || '',
      'other_memo' => shop.other_memo || '',
      'parking' => shop.parking || '',
      'party_capacity' => shop.party_capacity || 0,
      'pet' => shop.pet || '',
      'photo' => {
        'mobile' => {
          'l' => shop.photo_mobile_l || '',
          's' => shop.photo_mobile_s || ''
        },
        'pc' => {
          'l' => shop.photo_pc_l || '',
          'm' => shop.photo_pc_m || '',
          's' => shop.photo_pc_s || ''
        }
      },
      'private_room' => shop.private_room || '',
      'service_area' => {
        'code' => shop.service_area_code || '',
        'name' => shop.service_area_name || ''
      },
      'shop_detail_memo' => shop.shop_detail_memo || '',
      'show' => shop.show || '',
      'small_area' => {
        'code' => shop.small_area_code || '',
        'name' => shop.small_area_name || ''
      },
      'sommelier' => shop.sommelier || '',
      'station_name' => shop.station_name || '',
      'sub_genre' => {
        'code' => shop.sub_genre_code || '',
        'name' => shop.sub_genre_name || ''
      },
      'tatami' => shop.tatami || '',
      'tv' => shop.tv || '',
      'urls' => { 'pc' => shop.urls_pc || '' },
      'wedding' => shop.wedding || '',
      'wifi' => shop.wifi || ''
    }
  end
end
