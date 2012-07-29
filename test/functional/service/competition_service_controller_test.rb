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

  test "0003_getParties" do
    get :get_parties, {format: "json", competition_id: 1}
    parties = JSON.parse(@response.body)
    parties.each do |party|
      if party["id"] == 1
        assert party["self"]
      end
    end
  end

end
