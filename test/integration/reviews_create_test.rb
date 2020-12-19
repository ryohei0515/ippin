require 'test_helper'

class ReviewsCreateTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:michael)
  end

  test "successful create review" do
    log_in_as(@user)
    get new_review_path
    assert_difference 'Review.count', 1 do
      post reviews_path, params: { review: {content: "コンテンツ",
                                             food: "フード"} }
    end
    follow_redirect!
    assert_template 'static_pages/home'
    assert_not flash.empty?
  end

  test "unsuccessful create review" do
    log_in_as(@user)
    get new_review_path
    assert_no_difference 'Review.count' do
      post reviews_path, params: { review: {content: "",
                                             food: ""} }
    end
    assert_template 'reviews/new'
  end
end
