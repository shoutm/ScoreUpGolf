require 'test_helper'

class Scaffold::CompetitionsControllerTest < ActionController::TestCase
  setup do
    @competition = competitions(:one)
  end

  test "should get index" do
    get :index, nil, {user_id: 100}
    assert_response :success
    assert_not_nil assigns(:competitions)
  end

  test "should get new" do
    get :new, nil, {user_id: 100}
    assert_response :success
  end

  test "should create competition" do
    assert_difference('Competition.count') do
      post :create, {competition: @competition.attributes}, {user_id: 100}
    end

    assert_redirected_to scaffold_competition_path(assigns(:competition))
  end

  test "should show competition" do
    get :show, {id: @competition.to_param}, {user_id: 100}
    assert_response :success
  end

  test "should get edit" do
    get :edit, {id: @competition.to_param}, {user_id: 100}
    assert_response :success
  end

  test "should update competition" do
    put :update, {id: @competition.to_param, competition: @competition.attributes}, {user_id: 100}
    assert_redirected_to scaffold_competition_path(assigns(:competition))
  end

  test "should destroy competition" do
    assert_difference('Competition.count', -1) do
      delete :destroy, {id: @competition.to_param}, {user_id: 100}
    end

    assert_redirected_to scaffold_competitions_path
  end
end
