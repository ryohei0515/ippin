# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Food, type: :model do
  it { is_expected.to have_many(:shop_foods) }

  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_length_of(:name).is_at_most(30) }
  it { is_expected.to validate_uniqueness_of(:name).case_insensitive }

  it { is_expected.to validate_length_of(:name_kana).is_at_most(50) }

  it { is_expected.to validate_presence_of(:category) }
  it { is_expected.to validate_length_of(:category).is_at_most(30) }

  it { is_expected.to validate_length_of(:description).is_at_most(200) }
end
