require 'test_helper'

class Scaffold::UsersControllerTest < ActionController::TestCase
  setup do
    @user = users(:one)
    @new_user = User.new({name: "testuser1", email: "testuser1@test.com", password: "password", role: "200"})
  end

  test "should get index" do
    get :index, nil, {user_id: 100}
    assert_response :success
    assert_not_nil assigns(:users)
  end

  test "should get new" do
    get :new, nil, {user_id: 100}
    assert_response :success
  end

  test "should create user" do
    assert_difference('User.count') do
      post :create, {user: @new_user.attributes}, {user_id: 100}
    end

    assert_redirected_to scaffold_user_path(assigns(:user))
  end

  test "should show user" do
    get :show, {id: @user.to_param}, {user_id: 100}
    assert_response :success
  end

  test "should get edit" do
    get :edit, {id: @user.to_param}, {user_id: 100}
    assert_response :success
  end

  test "should update user" do
    updated_user = User.new(@user.attributes)
    updated_user.email = "change@test.com"
    put :update, {id: @user.to_param, user: updated_user.attributes}, {user_id: 100}
    assert_redirected_to scaffold_user_path(assigns(:user))
  end

  test "should destroy user" do
    assert_difference('User.count', -1) do
      delete :destroy, {id: @user.to_param}, {user_id: 100}
    end

    assert_redirected_to scaffold_users_path
  end
end
