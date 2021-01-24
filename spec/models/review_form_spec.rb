# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ReviewForm, type: :model do
  # let(:review) { FactoryBot.create(:review) }
  let(:review) do
    Review.create!('user_id' => user.id,
                   'food_id' => food.id,
                   'content' => 'form_test_content',
                   'title' => 'form_test_title',
                   'rate' => 3.5)
  end
  let(:user) { FactoryBot.create(:user) }
  let(:food) do
    Food.create!(name: 'form_test_food', category: 'update_category',
                 restaurant: 'form_test_restaurant')
  end

  it { is_expected.to validate_presence_of(:user_id) }

  it { is_expected.to validate_presence_of(:food) }
  it { is_expected.to validate_length_of(:food).is_at_most(30) }

  it { is_expected.to validate_presence_of(:content) }
  it { is_expected.to validate_length_of(:content).is_at_most(400) }

  it { is_expected.to validate_presence_of(:title) }
  it { is_expected.to validate_length_of(:title).is_at_most(50) }

  it { is_expected.to validate_presence_of(:restaurant) }
  it { is_expected.to validate_length_of(:restaurant).is_at_most(50) }

  it {
    is_expected.to validate_numericality_of(:rate)
      .is_greater_than_or_equal_to(1)
  }
  it {
    is_expected.to validate_numericality_of(:rate)
      .is_less_than_or_equal_to(5)
  }

  it { is_expected.to validate_presence_of(:category) }
  it { is_expected.to validate_length_of(:category).is_at_most(15) }

  describe '#create' do
    before { user }
    context '存在しないfoodのレビューの場合' do
      it 'foodを登録すること' do
        form = ReviewForm.new({ 'user_id' => user.id,
                                'food' => 'form_test_food',
                                'content' => 'form_test_content',
                                'title' => 'form_test_title',
                                'restaurant' => 'form_test_restaurant',
                                'rate' => 3.5,
                                'category' => 'test_category' })
        expect { form.create }.to change { Food.count }.from(0).to(1)
      end
    end
    context '既に存在するfoodのレビューの場合' do
      it 'foodを登録しないこと' do
        form = ReviewForm.new({ 'user_id' => user.id,
                                'food' => food.name,
                                'content' => 'update_content',
                                'title' => 'update_title',
                                'restaurant' => food.restaurant,
                                'rate' => 3.5,
                                'category' => food.category })
        expect { form.create }.to_not change(Food, :count)
      end
    end
  end

  describe '#update' do
    context '存在しないfoodのレビューの場合' do
      it 'foodを登録すること' do
        form = ReviewForm.new({ 'user_id' => user.id,
                                'food' => 'update_food',
                                'content' => 'update_content',
                                'title' => 'update_title',
                                'restaurant' => 'update_restaurant',
                                'rate' => 3.5,
                                'category' => 'update_ctgry' }, review: review)
        expect { form.update }.to change { Food.count }.from(1).to(2)
      end
    end
    context '既に存在するfoodのレビューの場合' do
      it '既に存在するfoodのレビューの場合foodを登録しないこと' do
        form = ReviewForm.new({ 'user_id' => 1,
                                'food' => food.name,
                                'content' => 'update_content',
                                'title' => 'update_title',
                                'restaurant' => food.restaurant,
                                'rate' => 3.5,
                                'category' => food.category }, review: review)
        expect { form.create }.to_not change(Food, :count)
      end
    end
  end
end
