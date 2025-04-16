require "test_helper"

class UserCheckoutsControllerTest < ActionDispatch::IntegrationTest
  test "should get checkout" do
    get user_checkouts_checkout_url
    assert_response :success
  end

  test "should get create" do
    get user_checkouts_create_url
    assert_response :success
  end
end
