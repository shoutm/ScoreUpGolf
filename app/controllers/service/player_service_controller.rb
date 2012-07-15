class Service::PlayerServiceController < ApplicationController
  # == 概要
  # 引数にplayer_idが指定されていた場合、playerが所属するコンペにおけるスコアを全て取得する
  # 引数のcompetition_idが指定されていた場合、引数のcompetition_idとログイン中のユーザ情報からplayerを特定し、所属するコンペにおけるスコアを取得する
  # 
  # == 引数
  # player_id
  # 
  # == 出力例
  #   [
  #     {
  #       "created_at": "2012-07-12T23:45:07Z", 
  #       "golf_hole_id": 101, 
  #       "id": 201, 
  #       "pat_num": 2, 
  #       "player_id": 2, 
  #       "shot_num": 3, 
  #       "updated_at": "2012-07-12T23:45:07Z"
  #     }, 
  #     ...
  #   ]
  def get_scores
    if params[:player_id]
      p = Player.find(params[:player_id])
    elsif params[:competition_id]
      c = Competition.find(params[:competition_id])
      party = PartyUtils::get_joined_party(c.parties, @user)
      p = PartyUtils::get_player(@user, party)
    end

    respond_to do |format|
      format.json { render json: p.shot_results } 
    end
  rescue ActiveRecord::RecordNotFound => e 
    # TODO 
    render json: nil
  end

  # == 概要
  # 指定されたplayeridに対して指定されたスコアをセットする
  #
  # ==引数
  # player_id
  # golf_hole_id
  # shot_num
  # pat_num
  # 
  # == 返り値
  # 成功  : 200(httpステータスコードとして)
  # 失敗  : 400(httpステータスコードとして)
  def set_score
    # TODO 認証
    unless params[:player_id] && params[:golf_hole_id] && params[:shot_num] && params[:pat_num]
      render status: 400, text: nil
      return 
    end

    shot_result = ShotResult.new({player_id: params[:player_id],
                                  golf_hole_id: params[:golf_hole_id],
                                  shot_num: params[:shot_num],
                                  pat_num: params[:pat_num]})
    shot_result.save
    render status: 200, text: nil
  rescue Exception => e
    render status: 400, text: nil
  end
end
