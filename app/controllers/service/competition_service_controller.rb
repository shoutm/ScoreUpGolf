class Service::CompetitionServiceController < ApplicationController
  # 引数に指定されたcompetition_idに応じたコンペのホール情報をarrayとして返す
  # arrayにはプレイする順番通りにホールを格納する
  def get_holes
    # 該当competitionにuserが参加しているか
    # TODO

    # CompetitionとUserからUserが所属するPartyを取得
    c = Competition.find(params[:competition_id])
    party = PartyUtils::get_joined_party(c.parties, @user)

    # プレイするGolfHoleを取得
    first = c.firsthalf_cource.golf_holes.sort do |a,b|
      a.hole_no <=> b.hole_no
    end
    second = c.secondhalf_cource.golf_holes.sort do |a,b|
      a.hole_no <=> b.hole_no
    end

    holes = []
    if party.reverse_cource_order
      holes = second + first
    else
      holes = first + second
    end

    respond_to do |format|
      format.json { render json: holes } 
    end
  rescue ActiveRecord::RecordNotFound => e 
    # TODO 
    render json: nil
  end

  # 引数に指定されたcompetition_idに対応するコンペのparty情報を返す。(party内のplayer情報までは返さない)
  # リクエストを要求したユーザが属するpartyにはselfフラグを立てて返す
  def get_parties
    c = Competition.find(params[:competition_id])
    self_party = PartyUtils::get_joined_party(c.parties, @user)
    party_json = JSON.parse(c.parties.to_json)
    party_json.each do |party|
      if party["id"] == self_party.id
        party["self"] = true
        break
      end
    end
    
    respond_to do |format|
      format.json { render json: party_json } 
    end
  rescue ActiveRecord::RecordNotFound => e 
    # TODO 
    render json: nil
  end
end
