require 'test_helper'

class GolfHolesControllerTest < ActionController::TestCase
  setup do
    @golf_hole = golf_holes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:golf_holes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create golf_hole" do
    assert_difference('GolfHole.count') do
      post :create, golf_hole: @golf_hole.attributes
    end

    assert_redirected_to golf_hole_path(assigns(:golf_hole))
  end

  test "should show golf_hole" do
    get :show, id: @golf_hole.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @golf_hole.to_param
    assert_response :success
  end

  test "should update golf_hole" do
    put :update, id: @golf_hole.to_param, golf_hole: @golf_hole.attributes
    assert_redirected_to golf_hole_path(assigns(:golf_hole))
  end

  test "should destroy golf_hole" do
    assert_difference('GolfHole.count', -1) do
      delete :destroy, id: @golf_hole.to_param
    end

    assert_redirected_to golf_holes_path
  end
end
