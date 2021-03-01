# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ReviewForm, type: :model do
  let(:user) { FactoryBot.create(:user) }
  let(:food) { FactoryBot.create(:food) }
  let(:shop) { FactoryBot.create(:shop) }
  let(:shop_food) { FactoryBot.create(:shop_food) }
  let(:review) { FactoryBot.create(:review, user: user) }

  it { is_expected.to validate_presence_of(:user_id) }

  it { is_expected.to validate_presence_of(:food_id) }

  it { is_expected.to validate_presence_of(:content) }
  it { is_expected.to validate_length_of(:content).is_at_most(400) }

  it { is_expected.to validate_presence_of(:title) }
  it { is_expected.to validate_length_of(:title).is_at_most(50) }

  it { is_expected.to validate_presence_of(:shop_id) }

  it {
    is_expected.to validate_numericality_of(:rate)
      .is_greater_than_or_equal_to(1)
  }
  it {
    is_expected.to validate_numericality_of(:rate)
      .is_less_than_or_equal_to(5)
  }

  describe '#create' do
    before { user }
    context '存在しないshop_foodのレビューの場合' do
      it 'shop_foodを登録すること' do
        form = ReviewForm.new({ 'user_id' => user.id,
                                'food_id' => food.id,
                                'content' => 'form_test_content',
                                'title' => 'form_test_title',
                                'shop_id' => shop.id,
                                'rate' => 3.5 })
        expect { form.create }.to change { ShopFood.count }.from(0).to(1)
      end
    end
    context '既に存在するshop_foodのレビューの場合' do
      it 'shop_foodを登録しないこと' do
        form = ReviewForm.new({ 'user_id' => user.id,
                                'food_id' => shop_food.food_id,
                                'content' => 'update_content',
                                'title' => 'update_title',
                                'shop_id' => shop_food.shop_id,
                                'rate' => 3.5 })
        expect { form.create }.to_not change(ShopFood, :count)
      end
    end
  end

  describe '#update' do
    context '存在しないshop_foodのレビューの場合' do
      it 'shop_foodを登録すること' do
        form = ReviewForm.new({ 'user_id' => user.id,
                                'food_id' => food.id,
                                'content' => 'update_content',
                                'title' => 'update_title',
                                'shop_id' => shop.id,
                                'rate' => 3.5 }, review: review)
        expect { form.update }.to change { ShopFood.count }.from(1).to(2)
      end
    end
    context '既に存在するshop_foodのレビューの場合' do
      it '既に存在するshop_foodのレビューの場合foodを登録しないこと' do
        form = ReviewForm.new({ 'user_id' => user.id,
                                'food_id' => shop_food.food_id,
                                'content' => 'update_content',
                                'title' => 'update_title',
                                'shop_id' => shop_food.shop_id,
                                'rate' => 3.5 }, review: review)
        expect { form.create }.to_not change(ShopFood, :count)
      end
    end
  end
end
