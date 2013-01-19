require 'test_helper'

class Portal::IndexControllerTest < ActionController::TestCase
  test "should get index" do
    get :index, nil, {user_id: 1}
    assert_select "a[name=golf_friend_list]"
    assert_select "a[name=golf_friend_search]"
    assert_response :success
  end

  test "should get playing competition notice" do 
    ic = Portal::IndexController.new
    u = User.find(1)
    ic.instance_variable_set(:@user, u)
    notice = ic.send(:get_playing_competition_notice) 
    assert_equal notice.uri, "/competition/play/index?competition_id=2"
  end

  test "should not get playing competition notice when a player whom state is joined is not found on db " do 
    ic = Portal::IndexController.new
    u = User.find(7)
    ic.instance_variable_set(:@user, u)
    assert_nil ic.send(:get_playing_competition_notice) 
  end
end
