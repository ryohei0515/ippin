require 'rails_helper'

RSpec.describe ReviewForm, type: :model do

  let(:review) { FactoryBot.create(:review) }
  let(:user) { FactoryBot.create(:user) }

  it { is_expected.to validate_presence_of(:user_id) }

  it { is_expected.to validate_presence_of(:food) }
  it { is_expected.to validate_length_of(:food).is_at_most(30) }

  it { is_expected.to validate_presence_of(:content) }
  it { is_expected.to validate_length_of(:content).is_at_most(400) }

  it { is_expected.to validate_presence_of(:title) }
  it { is_expected.to validate_length_of(:title).is_at_most(50) }

  it { is_expected.to validate_presence_of(:restaurant) }
  it { is_expected.to validate_length_of(:restaurant).is_at_most(50) }

  it { is_expected.to validate_numericality_of(:rate).
         is_greater_than_or_equal_to(1) }
  it { is_expected.to validate_numericality_of(:rate).
          is_less_than_or_equal_to(5) }

  it { is_expected.to validate_presence_of(:category) }
  it { is_expected.to validate_length_of(:category).is_at_most(15) }


end
