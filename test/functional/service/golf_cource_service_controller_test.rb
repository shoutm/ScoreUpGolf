#encoding: UTF-8
require 'test_helper'

class Service::GolfCourceServiceControllerTest < ActionController::TestCase
  test "should get get_cources" do
    get :get_cources, {format: "json", golf_field_id: 1}, {user_id: 100001}
    cources = JSON.parse(@response.body)
    assert_not_nil(cources.find do |cource| cource["id"] == 11 && cource["name"] == "コース1-1" end)
    assert_not_nil(cources.find do |cource| cource["id"] == 12 && cource["name"] == "コース1-2" end)
  end

  test "fail to get get_cources when required parameters are not given" do
    get :get_cources, {format: "json"}, {user_id: 100001}
    assert_equal @response.body, "null"
  end

  test "fail to get get_cources when specified golf field doesn't found" do
    get :get_cources, {format: "json", golf_field_id: 999}, {user_id: 100001}
    assert_equal @response.body, "null"
  end
end
