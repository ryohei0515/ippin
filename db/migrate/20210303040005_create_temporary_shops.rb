class CreateTemporaryShops < ActiveRecord::Migration[6.0]
  def change
    create_table :temporary_shops, id: :string do |t|
      t.string :name
      t.string :logo_image
      t.string :name_kana
      t.string :address
      t.string :station_name
      t.integer :ktai_coupon
      t.string :large_service_area_code
      t.string :large_service_area_name
      t.string :service_area_code
      t.string :service_area_name
      t.string :large_area_code
      t.string :large_area_name
      t.string :middle_area_code
      t.string :middle_area_name
      t.string :small_area_code
      t.string :small_area_name
      t.float :lat
      t.float :lng
      t.string :genre_code
      t.string :genre_name
      t.string :genre_catch
      t.string :sub_genre_code
      t.string :sub_genre_name
      t.string :budget_code
      t.string :budget_name
      t.string :budget_average
      t.string :budget_memo
      t.string :catch
      t.integer :capacity
      t.string :access
      t.string :mobile_access
      t.string :urls_pc
      t.string :photo_pc_l
      t.string :photo_pc_m
      t.string :photo_pc_s
      t.string :photo_mobile_l
      t.string :photo_mobile_s
      t.string :open
      t.string :close
      t.integer :party_capacity
      t.string :wifi
      t.string :wedding
      t.string :course
      t.string :free_drink
      t.string :free_food
      t.string :private_room
      t.string :horigotatsu
      t.string :tatami
      t.string :card
      t.string :non_smoking
      t.string :charter
      t.string :ktai
      t.string :parking
      t.string :barrier_free
      t.string :other_memo
      t.string :sommelier
      t.string :open_air
      t.string :show
      t.string :equipment
      t.string :karaoke
      t.string :band
      t.string :tv
      t.string :english
      t.string :pet
      t.string :child
      t.string :lunch
      t.string :midnight
      t.string :shop_detail_memo
      t.string :coupon_urls_pc
      t.string :coupon_urls_sp
      t.string :search_keyword

      t.timestamps
    end
    add_index :temporary_shops, :search_keyword
  end
end

