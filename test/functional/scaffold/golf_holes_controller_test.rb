require 'test_helper'

class Scaffold::GolfHolesControllerTest < ActionController::TestCase
  setup do
    @golf_hole = golf_holes(:one)
  end

  test "should get index" do
    get :index, nil, {user_id: 100}
    assert_response :success
    assert_not_nil assigns(:golf_holes)
  end

  test "should get new" do
    get :new, nil, {user_id: 100}
    assert_response :success
  end

  test "should create golf_hole" do
    assert_difference('GolfHole.count') do
      post :create, {golf_hole: @golf_hole.attributes}, {user_id: 100}
    end

    assert_redirected_to scaffold_golf_hole_path(assigns(:golf_hole))
  end

  test "should show golf_hole" do
    get :show, {id: @golf_hole.to_param}, {user_id: 100}
    assert_response :success
  end

  test "should get edit" do
    get :edit, {id: @golf_hole.to_param}, {user_id: 100}
    assert_response :success
  end

  test "should update golf_hole" do
    put :update, {id: @golf_hole.to_param, golf_hole: @golf_hole.attributes}, {user_id: 100}
    assert_redirected_to scaffold_golf_hole_path(assigns(:golf_hole))
  end

  test "should destroy golf_hole" do
    assert_difference('GolfHole.count', -1) do
      delete :destroy, {id: @golf_hole.to_param}, {user_id: 100}
    end

    assert_redirected_to scaffold_golf_holes_path
  end
end
