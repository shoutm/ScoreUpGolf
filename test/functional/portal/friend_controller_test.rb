require 'test_helper'

class Portal::FriendControllerTest < ActionController::TestCase
  test "should get index" do
    get :index, nil, {user_id: 1}
    assert_select "a[name=2]"
    assert_response :success
  end
end
