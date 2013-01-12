# encoding: UTF-8
require 'test_helper'

class Portal::FriendControllerTest < ActionController::TestCase
  test "should get index" do
    get :index, nil, {user_id: 1}
    assert_select "a[name=2]"
    assert_select "section[data-role=navbar]"
    assert_response :success
  end

  test "should get search" do 
    get :search, nil, {user_id: 1}
    assert_select "section[data-role=navbar]"
    assert_response :success
  end

  test "should get show" do 
    # a case that they are friends
    get :show, {user_id: 100002}, {user_id: 100001}
    assert_select "div[id=state]", {text: "ゴルフレ"}
    assert_select "button[id=cancel]" 
    assert_response :success

    # a case that the user has sent a friend request
    get :show, {user_id: 100003}, {user_id: 100001}
    assert_select "div[id=state]", {text: "ゴルフレ申請中"}
    assert_select "button[id=cancel]"

    # a case that the user was sent a friend request
    get :show, {user_id: 100004}, {user_id: 100001}
    assert_select "div[id=state]", {text: "ゴルフレ申請受領中"}
    assert_select "button[id=accept]"
    assert_select "button[id=deny]"

    # a case that the they are not friends
    get :show, {user_id: 100005}, {user_id: 100001}
    assert_select "button[id=request]"

    # a case that the user was denied a friend request 
    get :show, {user_id: 100006}, {user_id: 100001}
    assert_select "button[id=accept]"

    get :show, nil, {user_id: 1}
    assert_select "h2[id=error]"
  end
end
