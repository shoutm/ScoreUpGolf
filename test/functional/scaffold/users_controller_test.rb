require 'test_helper'

class Scaffold::UsersControllerTest < ActionController::TestCase
  setup do
    @user = users(:one)
    # TODO change role and openid value
    @new_user = User.new({name: "testuser1", openid: "testuser1@test.com", email: "testuser1@test.com", password: "password", role: "admin"})
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:users)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create user" do
    assert_difference('User.count') do
      post :create, user: @new_user.attributes
    end

    assert_redirected_to scaffold_user_path(assigns(:user))
  end

  test "should show user" do
    get :show, id: @user.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @user.to_param
    assert_response :success
  end

  test "should update user" do
    updated_user = User.new(@user.attributes)
    updated_user.email = "change@test.com"
    put :update, id: @user.to_param, user: updated_user.attributes
    assert_redirected_to scaffold_user_path(assigns(:user))
  end

  test "should destroy user" do
    assert_difference('User.count', -1) do
      delete :destroy, id: @user.to_param
    end

    assert_redirected_to scaffold_users_path
  end
end
