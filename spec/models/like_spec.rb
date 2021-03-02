# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Like, type: :model do
  subject { FactoryBot.build(:like) }

  it { is_expected.to validate_presence_of(:user_id) }
  it { should belong_to(:user) }
  it { is_expected.to validate_uniqueness_of(:user_id).scoped_to(:review_id) }

  it { is_expected.to validate_presence_of(:review_id) }
  it { should belong_to(:review) }
end
