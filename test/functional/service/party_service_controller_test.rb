require 'test_helper'

class Service::PartyServiceControllerTest < ActionController::TestCase
  test "should get party with user" do 
    get :get_party_with_user, {format: "json", party_id: 11}, {user_id: 1}
    party = JSON.parse(@response.body)
    assert_equal party["party_no"], 1
    assert !party["reverse_cource_order"]
    
    # userまで取得出来ているかどうかの確認
    assert_nothing_raised(Exception) do 
      party["players"].each do |player|
        player["user"]["id"] 
      end
    end

    # selfフラグの確認
    flag = false
    party["players"].each do |player|
      if player["user_id"] == 1 && player["self"] == true
        flag = true
      end
    end
    assert flag
  end

  test "should get party when party is not found on db" do 
    get :get_party_with_user, {format: "json", party_id: 245921}, {user_id: 1}
    assert_equal @response.body, "null"
  end
end
