require 'rails_helper'

RSpec.describe Food, type: :model do
  xit { should have_many(:reviews) }

  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_length_of(:name).is_at_most(30) }

  xit { is_expected.to validate_presence_of(:category) }
  it { is_expected.to validate_length_of(:category).is_at_most(15) }

  it { is_expected.to validate_presence_of(:restaurant) }
  it { is_expected.to validate_length_of(:restaurant).is_at_most(50) }
end
