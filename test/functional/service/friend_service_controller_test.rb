require 'test_helper'

class Service::FriendServiceControllerTest < ActionController::TestCase
  test "should get apply" do
    get :apply, {format: "json", user_id: 100007}, {user_id: 100001}
    assert_equal FriendRelation.find(:all, conditions: {user_id: 100001, friend_id: 100007, state: FriendRelation::State::REQUESTING}).size, 1
    assert_equal FriendRelation.find(:all, conditions: {user_id: 100007, friend_id: 100001, state: FriendRelation::State::BE_REQUESTED}).size, 1
    assert_response :success
  end

  test "should not get apply when required parameters are not given" do
    get :apply, {format: "json"}, {user_id: 100001}
    assert_response 400
  end

  test "should get accept" do
    # a user(100004) is applying to a user(100001)
    get :accept, {format: "json", user_id: 100004}, {user_id: 100001}
    assert_equal FriendRelation.find(:all, conditions: {user_id: 100001, friend_id: 100004, state: FriendRelation::State::BE_FRIENDS}).size, 1
    assert_equal FriendRelation.find(:all, conditions: {user_id: 100004, friend_id: 100001, state: FriendRelation::State::BE_FRIENDS}).size, 1
    assert_response :success

    # a user(100006) is applying to a user(100001) but the latter user is denying.
    get :accept, {format: "json", user_id: 100006}, {user_id: 100001}
    assert_equal FriendRelation.find(:all, conditions: {user_id: 100001, friend_id: 100006, state: FriendRelation::State::BE_FRIENDS}).size, 1
    assert_equal FriendRelation.find(:all, conditions: {user_id: 100006, friend_id: 100001, state: FriendRelation::State::BE_FRIENDS}).size, 1
    assert_response :success
  end

  test "should not get accept when there is no suitable apply" do
    # a case that they are already friends
    get :accept, {format: "json", user_id: 100002}, {user_id: 100001}
    assert_response 400

    # a case that an applying user sends "accept-request"
    get :accept, {format: "json", user_id: 100003}, {user_id: 100001}
    assert_response 400

    # a case that they are already breaked off
    get :accept, {format: "json", user_id: 100005}, {user_id: 100001}
    assert_response 400

    # a case that there are no records that fit designated users in friend_relations table
    get :accept, {format: "json", user_id: 100007}, {user_id: 100001}
    assert_response 400
  end

  test "should not get accept when required parameters are not given" do
    get :accept, {format: "json"}, {user_id: 100001}
    assert_response 400
  end

  test "should get cancel" do
    get :cancel, {format: "json", user_id: 100003}, {user_id: 100001}
    assert_equal FriendRelation.find(:all, conditions: {user_id: 100001, friend_id: 100003, state: FriendRelation::State::REQUESTING}).size, 0
    assert_equal FriendRelation.find(:all, conditions: {user_id: 100003, friend_id: 100001, state: FriendRelation::State::BE_REQUESTED}).size, 0
    assert_response :success
    get :cancel, {format: "json", user_id: 100002}, {user_id: 100001}
    assert_equal FriendRelation.find(:all, conditions: {user_id: 100001, friend_id: 100002, state: FriendRelation::State::BE_FRIENDS}).size, 0
    assert_equal FriendRelation.find(:all, conditions: {user_id: 100002, friend_id: 100001, state: FriendRelation::State::BE_FRIENDS}).size, 0
    assert_response :success
  end

  test "should not get cancel when there is no suitable apply or relation" do
    # a case that an canceling user has already sent "accept-request"
    get :cancel, {format: "json", user_id: 100004}, {user_id: 100001}
    assert_response 400

    # a case that they are already breaked off
    get :cancel, {format: "json", user_id: 100005}, {user_id: 100001}
    assert_response 400

    # a case that a user(100006) is applying to a user(100001) but the latter user is denying.
    get :cancel, {format: "json", user_id: 100006}, {user_id: 100001}
    assert_response 400

    # a case that there are no records that fit designated users in friend_relations table
    get :cancel, {format: "json", user_id: 100007}, {user_id: 100001}
    assert_response 400
  end

  test "should not get cancel when required parameters are not given" do
    get :cancel, {format: "json"}, {user_id: 100001}
    assert_response 400
  end

  test "should get deny" do
    get :deny, {format: "json", user_id: 100004}, {user_id: 100001}
    assert_equal FriendRelation.find(:all, conditions: {user_id: 100001, friend_id: 100004, state: FriendRelation::State::DENIED}).size, 1
    assert_equal FriendRelation.find(:all, conditions: {user_id: 100004, friend_id: 100001, state: FriendRelation::State::REQUESTING}).size, 1
    assert_response :success
  end

  test "should not get deny when there is no suitable apply" do
    # a case that they are friends
    get :deny, {format: "json", user_id: 100002}, {user_id: 100001}
    assert_response 400

    # a case that an denying user has already sent "accept-request"
    get :deny, {format: "json", user_id: 100003}, {user_id: 100001}
    assert_response 400

    # a case that they are already breaked off
    get :deny, {format: "json", user_id: 100005}, {user_id: 100001}
    assert_response 400

    # a case that a user(100006) already deny a user(100001)
    get :deny, {format: "json", user_id: 100006}, {user_id: 100001}
    assert_response 400

    # a case that there are no records that fit designated users in friend_relations table
    get :deny, {format: "json", user_id: 100007}, {user_id: 100001}
    assert_response 400
  end

  test "should not get deny when required parameters are not given" do
    get :deny, {format: "json"}, {user_id: 100001}
    assert_response 400
  end

end
