require 'test_helper'

class Scaffold::GolfCourcesControllerTest < ActionController::TestCase
  setup do
    @golf_cource = golf_cources(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:golf_cources)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create golf_cource" do
    assert_difference('GolfCource.count') do
      post :create, golf_cource: @golf_cource.attributes
    end

    assert_redirected_to scaffold_golf_cource_path(assigns(:golf_cource))
  end

  test "should show golf_cource" do
    get :show, id: @golf_cource.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @golf_cource.to_param
    assert_response :success
  end

  test "should update golf_cource" do
    put :update, id: @golf_cource.to_param, golf_cource: @golf_cource.attributes
    assert_redirected_to scaffold_golf_cource_path(assigns(:golf_cource))
  end

  test "should destroy golf_cource" do
    assert_difference('GolfCource.count', -1) do
      delete :destroy, id: @golf_cource.to_param
    end

    assert_redirected_to scaffold_golf_cources_path
  end
end
