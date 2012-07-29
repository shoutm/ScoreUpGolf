require 'test_helper'

class Service::PartyServiceControllerTest < ActionController::TestCase
  test "0001_get_party_with_user" do 
    get :get_party_with_user, {format: "json", party_id: 1}
    party = JSON.parse(@response.body)
    assert_equal party["party_no"], 1
    assert !party["reverse_cource_order"]
    
    # userまで取得出来ているかどうかの確認
    assert_nothing_raised(Exception) do 
      party["players"].each do |player|
        player["user"]["id"]
      end
    end
  end
end
