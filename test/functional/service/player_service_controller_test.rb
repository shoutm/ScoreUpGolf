require 'test_helper'

class Service::PlayerServiceControllerTest < ActionController::TestCase
  test "0001 getPlayer" do
    # TODO ユーザが選択できるようになったら改めてテストを作成する
    get :get_player
    assert_response :success
  end

  # player_idを指定した場合
  test "0002 getScores" do
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
  test "0003 getScores" do
    # TODO 
  end
end
