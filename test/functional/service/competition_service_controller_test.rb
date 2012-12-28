require 'test_helper'

class Service::CompetitionServiceControllerTest < ActionController::TestCase
  test "should not get holes when a user does not join an offered competition" do
    # ユーザが指定コンペに参加していなかった場合
    get :get_holes, {format: "json", competition_id: 1}, {user_id: 5}
    assert_equal @response.body, "null"
  end

  test "should not get holes when a competition is not found on db" do
    get :get_holes, {format: "json", competition_id: 12453}, {user_id: 5}
    assert_equal @response.body, "null"
  end

  test "should get holes" do
    # 適切なホール情報が入っているか？
    get :get_holes, {format: "json", competition_id: 1}, {user_id: 1}
    holes = JSON.parse(@response.body)

    flag = true
    0.upto(8) do |i|
      if holes[i]["id"] != (1100 + i + 1) ||  holes[i]["hole_no"] != (i + 1) || holes[i]["par"] == nil || holes[i]["yard"] == nil
        flag = false
      end
    end
    9.upto(17) do |i|
      if holes[i]["id"] != (1200 + i + 1) ||  holes[i]["hole_no"] != (i + 1) || holes[i]["par"] == nil || holes[i]["yard"] == nil
        flag = false
      end
    end

    assert flag
  end

  test "should get parties" do
    get :get_parties, {format: "json", competition_id: 1}, {user_id: 1}
    parties = JSON.parse(@response.body)
    flag = false
    parties.each do |party|
      if party["id"] == 11 && party["self"]
        flag = true
      end
    end

    assert flag
  end

  test "should not get parties when a user does not join an offered competition" do
    get :get_parties, {format: "json", competition_id: 1}, {user_id: 5}
    assert_equal @response.body, "null"
  end

  test "should not get parties when a competition is not found on db" do
    get :get_parties, {format: "json", competition_id: 12453}, {user_id: 5}
    assert_equal @response.body, "null"
  end
end
