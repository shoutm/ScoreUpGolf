require 'test_helper'

class Service::CompetitionServiceControllerTest < ActionController::TestCase
  test "0001_getHoles" do
    # ユーザが指定コンペに参加していなかった場合
    get :get_holes, {format: "json", competition_id: 1}
    # TODO
  end

  test "0002_getHoles" do
    # 適切なホール情報が入っているか？
    get :get_holes, {format: "json", competition_id: 1}
    holes = JSON.parse(@response.body)
Rails.logger.debug "CompetitionServiceController/0002: holes = #{holes}"
Rails.logger.debug "CompetitionServiceController/0002: holes.class = #{holes.class}"

    ok_flag = true

    for i in 0..8
      Rails.logger.debug "CompetitionServiceController/0002: holes[#{i}] = #{holes[i]}"
      if holes[i]["id"] != (100+i+1) ||  holes[i]["hole_no"] != (i+1) || holes[i]["par"] == nil || holes[i]["yard"] == nil
        Rails.logger.debug "CompetitionServiceController/0002: ok_flag = false"
        ok_flag = false
      end
    end
    for i in 9..17
      Rails.logger.debug "CompetitionServiceController/0002: holes[#{i}] = #{holes[i]}"
      if holes[i]["id"] != (200+i+1) ||  holes[i]["hole_no"] != (i+1) || holes[i]["par"] == nil || holes[i]["yard"] == nil
        Rails.logger.debug "CompetitionServiceController/0002: ok_flag = false"
        ok_flag = false
      end
    end

    assert ok_flag
  end

  test "0003_getPlayersInJoinedParty" do
    get :get_players_in_joined_party, {format: "json", competition_id: 1}
    players = JSON.parse(@response.body)

    ok_flag = true

    for i in 0..3
      if players[i]["id"] != (i+1) || players[i]["party_id"] != 1 || players[i]["user_id"] != (i+1)
        ok_flag = false
      end
    end

    assert ok_flag
  end

  test "0004_getPlayersInJoinedParty" do
    get :get_players_in_joined_party, {format: "json", competition_id: 1, without_myself: "true"}
    players = JSON.parse(@response.body)

    ok_flag = true

# TODO ログインしているユーザ以外の情報が返ってくる
#    for i in 0..3
#      if players[i]["id"] != (i+1) || players[i]["party_id"] != 1 || players[i]["user_id"] != (i+1)
#        ok_flag = false
#      end
#    end

    assert ok_flag
  end
end
