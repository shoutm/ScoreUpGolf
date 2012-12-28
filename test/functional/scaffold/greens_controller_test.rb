require 'test_helper'

class Scaffold::GreensControllerTest < ActionController::TestCase
  setup do
    @green = greens(:one)
  end

  test "should get index" do
    get :index, nil, {user_id: 100}
    assert_response :success
    assert_not_nil assigns(:greens)
  end

  test "should get new" do
    get :new, nil, {user_id: 100}
    assert_response :success
  end

  test "should create green" do
    assert_difference('Green.count') do
      post :create, {green: @green.attributes}, {user_id: 100}
    end

    assert_redirected_to scaffold_green_path(assigns(:green))
  end

  test "should show green" do
    get :show, {id: @green.to_param}, {user_id: 100}
    assert_response :success
  end

  test "should get edit" do
    get :edit, {id: @green.to_param}, {user_id: 100}
    assert_response :success
  end

  test "should update green" do
    put :update, {id: @green.to_param, green: @green.attributes}, {user_id: 100}
    assert_redirected_to scaffold_green_path(assigns(:green))
  end

  test "should destroy green" do
    assert_difference('Green.count', -1) do
      delete :destroy, {id: @green.to_param}, {user_id: 100}
    end

    assert_redirected_to scaffold_greens_path
  end
end
