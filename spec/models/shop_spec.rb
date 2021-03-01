# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Shop, type: :model do
  it { is_expected.to have_many(:shop_foods) }

  it { is_expected.to validate_presence_of(:id) }
  it { is_expected.to validate_presence_of(:large_area) }
  it { is_expected.to validate_presence_of(:middle_area) }
end
