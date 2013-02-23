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

end
