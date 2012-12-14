require 'test_helper'

class Competition::CompetitionControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get view" do
    get :view
    assert_response :success
  end

  test "should get wait" do
    get :wait
    assert_response :success
  end

  test "should get finish" do
    get :finish
    # TODO ユーザが選択できるようになったら改めてテストを作成する
    assert true
  end
end
