require 'test_helper'

class SessionControllerTest < ActionController::TestCase
  test "should get login" do
    get :login
    assert_response :success
  end

  test "should get callback" do
    get :callback
    assert_response :redirect
  end

  test "should get destroy and delete session value" do
    get :destroy, nil, {user_id: 1}
    assert_response :success
    assert_equal @request.session["user_id"], nil
  end
end
