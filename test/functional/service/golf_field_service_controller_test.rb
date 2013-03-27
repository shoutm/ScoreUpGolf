#encoding: UTF-8
require 'test_helper'

class Service::GolfFieldServiceControllerTest < ActionController::TestCase
  test "should get search" do
    get :search, {format: "json", name: "ゴルフ"}, {user_id: 100001}
    fields = JSON.parse(@response.body)
    assert_not_nil(fields.find do |field| field["id"] == 1 && field["name"] == "ゴルフ場1" && field["region"] == 100 end)
    assert_not_nil(fields.find do |field| field["id"] == 2 && field["name"] == "ゴルフ場2" && field["region"] == 100 end)
  end

  test "fail to get search when required parameters are not given" do
    get :search, {format: "json"}, {user_id: 100001}
    assert_equal @response.body, "null"
  end

  test "fail to get search when no golf fields found" do
    get :search, {format: "json", name: "ゴルフフフ"}, {user_id: 100001}
    assert_equal @response.body, "null"
  end
end
