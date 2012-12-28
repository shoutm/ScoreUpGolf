require 'test_helper'

class Scaffold::PartiesControllerTest < ActionController::TestCase
  setup do
    @party = parties(:one)
  end

  test "should get index" do
    get :index, nil, {user_id: 100}
    assert_response :success
    assert_not_nil assigns(:parties)
  end

  test "should get new" do
    get :new, nil, {user_id: 100}
    assert_response :success
  end

  test "should create party" do
    assert_difference('Party.count') do
      post :create, {party: @party.attributes}, {user_id: 100}
    end

    assert_redirected_to scaffold_party_path(assigns(:party))
  end

  test "should show party" do
    get :show, {id: @party.to_param}, {user_id: 100}
    assert_response :success
  end

  test "should get edit" do
    get :edit, {id: @party.to_param}, {user_id: 100}
    assert_response :success
  end

  test "should update party" do
    put :update, {id: @party.to_param, party: @party.attributes}, {user_id: 100}
    assert_redirected_to scaffold_party_path(assigns(:party))
  end

  test "should destroy party" do
    assert_difference('Party.count', -1) do
      delete :destroy, {id: @party.to_param}, {user_id: 100}
    end

    assert_redirected_to scaffold_parties_path
  end
end
