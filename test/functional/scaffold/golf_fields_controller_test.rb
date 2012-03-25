require 'test_helper'

class Scaffold::GolfFieldsControllerTest < ActionController::TestCase
  setup do
    @golf_field = golf_fields(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:golf_fields)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create golf_field" do
    assert_difference('GolfField.count') do
      post :create, golf_field: @golf_field.attributes
    end

    assert_redirected_to scaffold_golf_field_path(assigns(:golf_field))
  end

  test "should show golf_field" do
    get :show, id: @golf_field.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @golf_field.to_param
    assert_response :success
  end

  test "should update golf_field" do
    put :update, id: @golf_field.to_param, golf_field: @golf_field.attributes
    assert_redirected_to scaffold_golf_field_path(assigns(:golf_field))
  end

  test "should destroy golf_field" do
    assert_difference('GolfField.count', -1) do
      delete :destroy, id: @golf_field.to_param
    end

    assert_redirected_to scaffold_golf_fields_path
  end
end
