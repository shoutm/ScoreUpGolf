require 'test_helper'

class Service::UserServiceControllerTest < ActionController::TestCase
  test "should search users" do
    get :search, {format: "json", name: "User", email: "_test@test.com"}, {user_id: 1}
    users = JSON.parse(@response.body) # This contains users whom id are 10000[1,2,3]
    assert_not_nil(users.find do |user| user["id"] == 100001 && user["name"] == "User1" && user["email"] == "user1_test@test.com" end)
    assert_not_nil(users.find do |user| user["id"] == 100002 && user["name"] == "User2" && user["email"] == "user2_test@test.com" end)
    assert_not_nil(users.find do |user| user["id"] == 100003 && user["name"] == "User3" && user["email"] == "user3_test@test.com" end)
    assert_response :success

    get :search, {format: "json", name: "User1"}, {user_id: 1}
    users = JSON.parse(@response.body) # This contains a user whom id is 100001
    assert_not_nil(users.find do |user| user["id"] == 100001 && user["name"] == "User1" && user["email"] == "user1_test@test.com" end)

    get :search, {format: "json", email: "user2_test@test.com"}, {user_id: 1}
    users = JSON.parse(@response.body) # This contains a user whom id is 100002
    assert_not_nil(users.find do |user| user["id"] == 100002 && user["name"] == "User2" && user["email"] == "user2_test@test.com" end)
  end

  test "should search users with friend_state" do
    get :search_with_friendstate, {format: "json", name: "User", email: "_test@test.com"}, {user_id: 100001}
    users = JSON.parse(@response.body) # This contains users whom id are 10000[2,3] and 100002 has a freind_state flag.
    assert_nil(users.find do |user| user["id"] == 100001 end)
    assert_not_nil(users.find do |user| user["id"] == 100002 && user["name"] == "User2" && user["email"] == "user2_test@test.com" && user["friend_state"] == FriendRelation::State::BE_FRIENDS end)
    assert_not_nil(users.find do |user| user["id"] == 100003 && user["name"] == "User3" && user["email"] == "user3_test@test.com" && user["friend_state"] == nil end)
  end

  test "should search null when there are no users matching given conditions" do
    get :search, {format: "json", name: "Henohenomoheji"}, {user_id: 1}
    assert_equal @response.body, "null"
    assert_response :success

    # A test for a method of search_with_friend_state
    get :search_with_friendstate, {format: "json", name: "Henohenomoheji"}, {user_id: 1}
    assert_equal @response.body, "null"
    assert_response :success
  end

  test "should search null when required parameters are not given" do
    get :search, {format: "json"}, {user_id: 1}
    assert_equal @response.body, "null"
    assert_response :success

    # A test for a method of search_with_friend_state
    get :search_with_friendstate, {format: "json"}, {user_id: 1}
    assert_equal @response.body, "null"
    assert_response :success
  end
end
