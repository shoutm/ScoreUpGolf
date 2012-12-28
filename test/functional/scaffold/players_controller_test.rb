require 'test_helper'

class Scaffold::PlayersControllerTest < ActionController::TestCase
  setup do
    @player = players(:one)
  end

  test "should get index" do
    get :index, nil, {user_id: 100}
    assert_response :success
    assert_not_nil assigns(:players)
  end

  test "should get new" do
    get :new, nil, {user_id: 100}
    assert_response :success
  end

  test "should create player" do
    assert_difference('Player.count') do
      post :create, {player: @player.attributes}, {user_id: 100}
    end

    assert_redirected_to scaffold_player_path(assigns(:player))
  end

  test "should show player" do
    get :show, {id: @player.to_param}, {user_id: 100}
    assert_response :success
  end

  test "should get edit" do
    get :edit, {id: @player.to_param}, {user_id: 100}
    assert_response :success
  end

  test "should update player" do
    put :update, {id: @player.to_param, player: @player.attributes}, {user_id: 100}
    assert_redirected_to scaffold_player_path(assigns(:player))
  end

  test "should destroy player" do
    assert_difference('Player.count', -1) do
      delete :destroy, {id: @player.to_param}, {user_id: 100}
    end

    assert_redirected_to scaffold_players_path
  end
end
