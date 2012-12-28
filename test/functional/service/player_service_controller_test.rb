require 'test_helper'

class Service::PlayerServiceControllerTest < ActionController::TestCase
  test "should get scores" do
    # competition_idを指定した場合
    get :get_scores, {format: "json", competition_id: 1}, {user_id: 1}
    scores = JSON.parse(@response.body)
    assert verify_for_get_scores(scores)

    # player_idを指定した場合
    get :get_scores, {format: "json", player_id: 1}, {user_id: 1}
    scores = JSON.parse(@response.body)
    assert verify_for_get_scores(scores)
  end

  test "should not get scores when player or competition are not found on db" do 
    get :get_scores, {format: "json", competition_id: 245998}, {user_id: 1}
    assert_equal @response.body, "null"

    get :get_scores, {format: "json", player_id: 245998}, {user_id: 1}
    assert_equal @response.body, "null"
  end

  test "should set scores" do
    post :set_score, {player_id: 5, golf_hole_id: 1, shot_num: 5, pat_num: 2}, {user_id: 1}
    sr = ShotResult.find(:all, conditions: {player_id: 5, golf_hole_id: 1})
    assert sr.size == 1 && sr[0].shot_num == 5 && sr[0].pat_num == 2
  end

  test "should not set scores when required params are not given" do
    post :set_score, {player_id: 5, golf_hole_id: 1, shot_num: 5}, {user_id: 1}
    assert_response 400
    post :set_score, {player_id: 5, golf_hole_id: 1, pat_num: 2}, {user_id: 1}
    assert_response 400
    post :set_score, {player_id: 5, shot_num: 5, pat_num: 2}, {user_id: 1}
    assert_response 400
    post :set_score, {golf_hole_id: 1, shot_num: 5, pat_num: 2}, {user_id: 1}
    assert_response 400
  end

  private 

  # common function for get_scores
  def verify_for_get_scores(scores)
    flag = true
    (101..109).each do |i|
      flag = false unless scores.find {|x| (x["id"] == i) && (x["player_id"] == 1) && (x["golf_hole_id"] == (i + 1000))}
    end
    (110..118).each do |i| 
      flag = false unless scores.find {|x| (x["id"] == i) && (x["player_id"] == 1) && (x["golf_hole_id"] == (i + 1100))}
    end
    return flag
  end
end
