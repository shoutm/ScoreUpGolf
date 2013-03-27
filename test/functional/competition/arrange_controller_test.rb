# encoding: UTF-8
require 'test_helper'
require 'date'

class Competition::ArrangeControllerTest < ActionController::TestCase
  test "should get index" do
    get :index, nil, {user_id: 100001}
    assert_response :success
    # check if selector options for competition date are set correctly.
    today = Date.today 
    years = [today.year, (today.year + 1)]
    months = []; (1..12).each do |m| months << m end
    days = []; (1..31).each do |d| days << d end
    years.each do |x|  assert_select "select#year option[value=#{x}]" end
    months.each do |x| assert_select "select#month option[value=#{x}]" end
    days.each do |x|   assert_select "select#day option[value=#{x}]" end
    assert_select "select#year option[value=#{today.year}][selected=true]"
    assert_select "select#month option[value=#{today.month}][selected=true]"
    assert_select "select#day option[value=#{today.day}][selected=true]"
  end

  test "should post confirm" do
    post :confirm, {competition_name: "テストコンペ", year: "2013", month: "1", day: "1", 
      user1_id: "1", user2_id: "2", user3_id: "3", user4_id: "4",
      golf_field_id: "1",
      firsthalf_cource_id: "11", secondhalf_cource_id: "12"}, {user_id: 1}
    assert_response :success
    assert_template "confirm"
  end

  test "should post finish" do
    post :finish, {competition_name: "テストコンペ", year: "2013", month: "1", day: "1", 
      user1_id: "1", user2_id: "2", user3_id: "3", user4_id: "4",
      golf_field_id: "1",
      firsthalf_cource_id: "11", secondhalf_cource_id: "12"}, {user_id: 1}
    competition = Competition.where(name: "テストコンペ", firsthalf_cource_id: 11, secondhalf_cource_id: 12, state: Competition::State::ARRANGED)
    assert_equal competition.size, 1
    party = Party.where(competition_id: competition.first.id)
    assert_equal party.size, 1
    players = Player.where(party_id: party.first.id, state: Player::State::JOINED)
    assert_equal players.size, 4
  end

  test "should not post confirm and finish when competition name is not given" do 
    [:confirm, :finish].each do |target|
      post target, {year: "2013", month: "1", day: "1", 
        user1_id: "1", user2_id: "2", user3_id: "3", user4_id: "4",
        golf_field_id: "1",
        firsthalf_cource_id: "11", secondhalf_cource_id: "12"}, {user_id: 1}
      assert_redirected_to action: "index"
    end
  end

  test "should not post confirm and finish when competition date is not given" do 
    [:confirm, :finish].each do |target|
      post target, {competition_name: "テストコンペ", month: "1", day: "1", 
        user1_id: "1", user2_id: "2", user3_id: "3", user4_id: "4",
        golf_field_id: "1",
        firsthalf_cource_id: "11", secondhalf_cource_id: "12"}, {user_id: 1}
      assert_redirected_to action: "index"
      post target, {competition_name: "テストコンペ", year: "2013", day: "1", 
        user1_id: "1", user2_id: "2", user3_id: "3", user4_id: "4",
        golf_field_id: "1",
        firsthalf_cource_id: "11", secondhalf_cource_id: "12"}, {user_id: 1}
      assert_redirected_to action: "index"
      post target, {competition_name: "テストコンペ", year: "2013", month: "1", 
        user1_id: "1", user2_id: "2", user3_id: "3", user4_id: "4",
        golf_field_id: "1",
        firsthalf_cource_id: "11", secondhalf_cource_id: "12"}, {user_id: 1}
      assert_redirected_to action: "index"
    end
  end

  test "should not post confirm and finish when no users are given" do 
    [:confirm, :finish].each do |target|
      post target, {competition_name: "テストコンペ", year: "2013", month: "1", day: "1", 
        golf_field_id: "1",
        firsthalf_cource_id: "11", secondhalf_cource_id: "12"}, {user_id: 1}
      assert_redirected_to action: "index"
    end
  end
  
  test "should post confirm and finish if at least one user is given" do 
    [:confirm, :finish].each do |target|
      post target, {competition_name: "テストコンペ", year: "2013", month: "1", day: "1", 
        user1_id: "1",
        golf_field_id: "1",
        firsthalf_cource_id: "11", secondhalf_cource_id: "12"}, {user_id: 1}
      assert_response :success
      assert_template target
    end
  end

  test "should not post confirm and finish when golf field id is not given" do 
    [:confirm, :finish].each do |target|
      post target, {competition_name: "テストコンペ", year: "2013", month: "1", day: "1", 
        user1_id: "1", user2_id: "2", user3_id: "3", user4_id: "4",
        firsthalf_cource_id: "11", secondhalf_cource_id: "12"}, {user_id: 1}
      assert_redirected_to action: "index"
    end
  end

  test "should not post confirm and finish when cource id's are not given" do 
    [:confirm, :finish].each do |target|
      post target, {competition_name: "テストコンペ", year: "2013", month: "1", day: "1", 
        user1_id: "1", user2_id: "2", user3_id: "3", user4_id: "4",
        golf_field_id: "1",
        secondhalf_cource_id: "12"}, {user_id: 1}
      assert_redirected_to action: "index"
      post target, {competition_name: "テストコンペ", year: "2013", month: "1", day: "1", 
        user1_id: "1", user2_id: "2", user3_id: "3", user4_id: "4",
        golf_field_id: "1",
        firsthalf_cource_id: "11"}, {user_id: 1}
      assert_redirected_to action: "index"
    end
  end
  
  test "should not post confirm and finish when wrong date is given" do 
    [:confirm, :finish].each do |target|
      post target, {competition_name: "テストコンペ", year: "2013", month: "2", day: "30", 
        user1_id: "1", user2_id: "2", user3_id: "3", user4_id: "4",
        golf_field_id: "1",
        firsthalf_cource_id: "11", secondhalf_cource_id: "12"}, {user_id: 1}
      assert_redirected_to action: "index"
    end
  end

  test "should not post confirm and finish if users are not friends" do 
    [:confirm, :finish].each do |target|
      post target, {competition_name: "テストコンペ", year: "2013", month: "1", day: "1", 
        user1_id: "1", user2_id: "2", user3_id: "3", user4_id: "98",
        golf_field_id: "1",
        firsthalf_cource_id: "11", secondhalf_cource_id: "12"}, {user_id: 1}
      assert_redirected_to action: "index"
    end
  end

  test "should not post confirm and finish if specified users doesn't exist" do 
    [:confirm, :finish].each do |target|
      post target, {competition_name: "テストコンペ", year: "2013", month: "1", day: "1", 
        user1_id: "1", user2_id: "2", user3_id: "3", user4_id: "999",
        golf_field_id: "1",
        firsthalf_cource_id: "11", secondhalf_cource_id: "12"}, {user_id: 1}
      assert_redirected_to action: "index"
    end
  end

  test "should not post confirm and finish if same users exist in members" do 
    [:confirm, :finish].each do |target|
      post target, {competition_name: "テストコンペ", year: "2013", month: "1", day: "1", 
        user1_id: "1", user2_id: "2", user3_id: "3", user4_id: "3",
        golf_field_id: "1",
        firsthalf_cource_id: "11", secondhalf_cource_id: "12"}, {user_id: 1}
      assert_redirected_to action: "index"
    end
  end

  test "should not post confirm and finish when applying user is not included in the competition member" do 
    [:confirm, :finish].each do |target|
      post target, {competition_name: "テストコンペ", year: "2013", month: "1", day: "1", 
        user1_id: "1", user2_id: "2", user3_id: "3", user4_id: "4",
        golf_field_id: "1",
        firsthalf_cource_id: "11", secondhalf_cource_id: "12"}, {user_id: 100001}
      assert_redirected_to action: "index"
    end
  end

  test "should not post confirm and finish if golf cources are not the golf field's cources" do 
    [:confirm, :finish].each do |target|
      post target, {competition_name: "テストコンペ", year: "2013", month: "1", day: "1", 
        user1_id: "1", user2_id: "2", user3_id: "3", user4_id: "4",
        golf_field_id: "1",
        firsthalf_cource_id: "11", secondhalf_cource_id: "21"}, {user_id: 1}
      assert_redirected_to action: "index"
      post target, {competition_name: "テストコンペ", year: "2013", month: "1", day: "1", 
        user1_id: "1", user2_id: "2", user3_id: "3", user4_id: "4",
        golf_field_id: "1",
        firsthalf_cource_id: "21", secondhalf_cource_id: "21"}, {user_id: 1}
      assert_redirected_to action: "index"
    end
  end

  test "should not post confirm and finish if golf field or cources doesn't exist" do 
    [:confirm, :finish].each do |target|
      post target, {competition_name: "テストコンペ", year: "2013", month: "1", day: "1", 
        user1_id: "1", user2_id: "2", user3_id: "3", user4_id: "4",
        golf_field_id: "999",
        firsthalf_cource_id: "11", secondhalf_cource_id: "12"}, {user_id: 1}
      assert_redirected_to action: "index"
      post target, {competition_name: "テストコンペ", year: "2013", month: "1", day: "1", 
        user1_id: "1", user2_id: "2", user3_id: "3", user4_id: "4",
        golf_field_id: "1",
        firsthalf_cource_id: "999", secondhalf_cource_id: "12"}, {user_id: 1}
      assert_redirected_to action: "index"
    end
  end
end
