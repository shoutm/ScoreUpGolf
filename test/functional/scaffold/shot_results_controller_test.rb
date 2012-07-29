require 'test_helper'

class Scaffold::ShotResultsControllerTest < ActionController::TestCase
  setup do
    @shot_result = shot_results(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:shot_results)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create shot_result" do
    assert_difference('ShotResult.count') do
      # unique制約を入れたことにより、fixturesと重複しないエントリを入れる必要
      @shot_result["golf_hole_id"] += 100002
      post :create, shot_result: @shot_result.attributes
    end

    assert_redirected_to scaffold_shot_result_path(assigns(:shot_result))
  end

  test "should show shot_result" do
    get :show, id: @shot_result.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @shot_result.to_param
    assert_response :success
  end

  test "should update shot_result" do
    put :update, id: @shot_result.to_param, shot_result: @shot_result.attributes
    assert_redirected_to scaffold_shot_result_path(assigns(:shot_result))
  end

  test "should destroy shot_result" do
    assert_difference('ShotResult.count', -1) do
      delete :destroy, id: @shot_result.to_param
    end

    assert_redirected_to scaffold_shot_results_path
  end
end
