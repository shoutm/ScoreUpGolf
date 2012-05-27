class Service::PartyServiceController < ApplicationController
  # 引数に指定されたparty_idに対するpartyの情報を返す。
  # partyに属するplayerに紐付くuserオブジェクトの情報も含む。
  # partyに属するplayerの中に@userと同じuser_idを持つものがいた場合、selfフラグを立てる
  #
  # 引数
  # party_id  
  def get_party_with_user
    party = Party.find(params[:party_id])
    party_json = JSON.parse(party.to_json(:include => {:players => {:include => :user}}))
    party_json["players"].each do |player|
      if player["user_id"] == @user.id
        player["self"] = true
        break
      end
    end

    respond_to do |format|
      format.json { render json: party_json} 
    end
  rescue ActiveRecord::RecordNotFound => e
    # TODO
    render json: nil
  end
end
