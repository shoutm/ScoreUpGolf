require 'test_helper'

class Service::PlayerServiceControllerTest < ActionController::TestCase
  test "0001_getScores" do
    get :get_scores, {format: "json", competition_id: 1}
    # TODO ユーザが選択できるようになったら改めてテストを作成する

    assert_response :success
  end

  # player_idを指定した場合
  test "0002_getScores" do
    get :get_scores, {format: "json", player_id: 1}
    scores = JSON.parse(@response.body)

    ok_flag = true

    for i in 101..109
      ok_flag = false unless scores.find {|x| (x["id"] == i) && (x["player_id"] == 1) && (x["golf_hole_id"] == i)}
    end
    for i in 110..118
      ok_flag = false unless scores.find {|x| (x["id"] == i) && (x["player_id"] == 1) && (x["golf_hole_id"] == (i+100))}
    end

    assert ok_flag
  end

  # competition_idを指定した場合
  test "0003_setScore" do
    post :set_score, {player_id: 5, golf_hole_id: 1, shot_num: 5, pat_num: 2}
    assert_response :success
  end
end
