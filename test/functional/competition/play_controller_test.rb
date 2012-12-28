require 'test_helper'

class Competition::PlayControllerTest < ActionController::TestCase
  test "should get index" do
    get :index, nil, {user_id: 1}
    assert_response :success
  end

  test "should get view" do
    get :view, nil, {user_id: 1}
    assert_response :success
  end

  test "should get wait" do
    get :wait, nil, {user_id: 1}
    assert_response :success
  end

  test "should get finish" do
    get :finish, nil, {user_id: 1}
    assert_response :success
    assert_equal Player.find(5).state, 30
    # Competition state does not change because there are players who are plaing yet
    assert_equal Competition.find(2).state, 30
  end

  test "should get finish and a competition state turns to 'finish'" do
    # regist shot_result
    shot_results = []
    1.upto(9).each do |i|
      shot_results << ShotResult.create({player_id: 13, golf_hole_id: (1100 + i), shot_num: 3, pat_num: 2})
    end
    10.upto(18).each do |i|
      shot_results << ShotResult.create({player_id: 13, golf_hole_id: (1200 + i), shot_num: 3, pat_num: 2})
    end
    get :finish, nil, {user_id: 9}
    assert_equal Competition.find(3).state, 40
  end

  test "should fail when player doesn't exist" do
    get :finish, nil, {user_id: 100003}
    assert_response 500
  end

  test "should fail when there is a player that joins several competition" do 
    Player.create({id: 5555, user_id: 9,party_id: 31, state: 20})
    get :finish, nil, {user_id: 9}
    assert_response 500
  end

  test "should fail when player's shot result's size is not 18" do 
    get :finish, nil, {user_id: 9}
    assert_response 500
  end
end
