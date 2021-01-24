# frozen_string_literal: true

require 'test_helper'

class ReviewTest < ActiveSupport::TestCase
  def setup
    @user = users(:michael)
    @review = @user.reviews.build(content: 'とてもおいしい', food: 'カレー')
  end

  test 'check user_id validates' do
    assert @review.valid?

    # presence
    @review.user_id = ' '
    assert_not @review.valid?
  end

  test 'check content validates' do
    assert @review.valid?

    # presence
    @review.content = ' '
    assert_not @review.valid?

    # length
    @review.content = 'a' * 401
    assert_not @review.valid?
    @review.content = 'a' * 400
    assert @review.valid?
  end

  test 'check food validates' do
    assert @review.valid?

    # presence
    @review.food = ' '
    assert_not @review.valid?

    # length
    @review.food = 'a' * 51
    assert_not @review.valid?
    @review.food = 'a' * 50
    assert @review.valid?
  end

  test 'order should be most recent first' do
    assert_equal reviews(:most_recent), Review.first
  end
end
