class Service::CompetitionServiceController < ApplicationController
  # == 概要
  # 引数に指定されたcompetition_idに応じたコンペのホール情報をarrayとして返す。
  # arrayにはプレイする順番通りにホールを格納する
  # == 引数
  # competition_id
  #
  # == 出力例
  #   [
  #     {
  #       "created_at": "2012-07-12T23:45:07Z", 
  #       "golf_cource_id": 1, 
  #       "hole_no": 1, 
  #       "id": 101, 
  #       "par": 5, 
  #       "updated_at": "2012-07-12T23:45:07Z", 
  #       "yard": 360
  #     }, 
  #     ...
  #   ]
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

  # == 概要
  # 引数に指定されたcompetition_idに対応するコンペのparty情報を返す。(party内のplayer情報までは返さない)
  # リクエストを要求したユーザが属するpartyにはselfフラグを立てて返す
  # == 引数
  # competition_id
  # == 出力例
  #   [
  #     {
  #       "competition_id": 1, 
  #       "created_at": "2012-07-24T14:40:11Z", 
  #       "id": 1, 
  #       "party_no": 1, 
  #       "reverse_cource_order": false, 
  #       "self": true, 
  #       "updated_at":
  #       "2012-07-24T14:40:11Z"
  #     },
  #     ..
  #   ]
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
