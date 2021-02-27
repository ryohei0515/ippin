# frozen_string_literal: true

FactoryBot.define do
  factory :shop do
    shop_list = %w[J001259384 J001233764 J001249396 J000133890 J001145797 J001261533 J001192710 J001262652 J001232591 J001098481
                   J001134948 J001259092 J001201296 J000026664 J000954142 J001214967 J001160220 J001263205 J000855812 J000021537
                   J001009043 J001262221 J001145421 J001040289 J001144745 J001164142 J001186305 J000151276 J001245689 J000466019
                   J000706284 J001202935 J000476916 J000678276 J001216022 J001013241 J000844770 J000012942 J001232551 J001147459
                   J000032393 J001203930 J001223480 J001219122 J001232305 J001265431 J000839427 J000108215 J001262072 J000187146]
    large_area_shop_list = %w[J001179509 J001050638 J000019443 J001250768 J001226192]
    middle_area_shop_list = %w[J001159920 J000471714 J000471732 J000471664 J000471367]

    sequence(:id) { |n| shop_list[n % 50] }
    sequence(:large_area) { |n| "large_area#{n % 50}" }
    sequence(:middle_area) { |n| "middle_area#{n % 50}" }

    trait :specific_large_area do
      sequence(:id) { |n| large_area_shop_list[n % 5] }
      large_area { 'Z022' }
    end

    trait :specific_middle_area do
      sequence(:id) { |n| middle_area_shop_list[n % 5] }
      large_area { 'Z023' }
      middle_area { 'Y356' }
    end
  end
end
