class Service::PartyServiceController < ApplicationController
  # == 概要
  # 引数に指定されたparty_idに対するpartyの情報を返す。
  # partyに属するplayerに紐付くuserオブジェクトの情報も含む。
  # partyに属するplayerの中に@userと同じuser_idを持つものがいた場合、selfフラグを立てる
  #
  # == 引数
  # party_id  
  #
  # == 出力例
  #   {
  #     "competition_id": 1, 
  #     "created_at": "2012-07-12T23:45:07Z", 
  #     "id": 1, 
  #     "party_no": 1, 
  #     "players": [
  #         {
  #           "created_at": "2012-07-12T23:45:07Z", 
  #           "id": 1, 
  #           "user_id": 1,
  #           "party_id": 1, 
  #           "self": true, 
  #           "updated_at": "2012-07-12T23:45:07Z", 
  #           "user": {
  #             "id": 1,
  #             "name": "hogehoge"
  #           }
  #         }, 
  #         ...
  #     ], 
  #     "reverse_cource_order": false, 
  #     "updated_at": "2012-07-12T23:45:07Z"
  #   }
  def get_party_with_user
    party = Party.find(params[:party_id])
    party_json = JSON.parse(party.to_json(
      :include => {
        :players => {
          :include => {
            :user => {
              :only => [:id, :name]
            }
          }
        }
      }
    ))

    p = party_json["players"].find do |player| player["user_id"] == @user.id end
    p["self"] = true
    
    respond_to do |format|
      format.json { render json: party_json} 
    end
  rescue ActiveRecord::RecordNotFound => e
    # TODO
    render json: nil
  end
end
