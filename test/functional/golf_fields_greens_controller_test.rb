require 'test_helper'

class GolfFieldsGreensControllerTest < ActionController::TestCase
  setup do
    @golf_fields_green = golf_fields_greens(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:golf_fields_greens)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create golf_fields_green" do
    assert_difference('GolfFieldsGreen.count') do
      post :create, golf_fields_green: @golf_fields_green.attributes
    end

    assert_redirected_to golf_fields_green_path(assigns(:golf_fields_green))
  end

  test "should show golf_fields_green" do
    get :show, id: @golf_fields_green.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @golf_fields_green.to_param
    assert_response :success
  end

  test "should update golf_fields_green" do
    put :update, id: @golf_fields_green.to_param, golf_fields_green: @golf_fields_green.attributes
    assert_redirected_to golf_fields_green_path(assigns(:golf_fields_green))
  end

  test "should destroy golf_fields_green" do
    assert_difference('GolfFieldsGreen.count', -1) do
      delete :destroy, id: @golf_fields_green.to_param
    end

    assert_redirected_to golf_fields_greens_path
  end
end
