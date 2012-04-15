class Service::CompetitionServiceController < ApplicationController
  def get_holes
    # 該当competitionにuserが参加しているか
    # TODO

    # CompetitionとUserからUserが所属するPartyを取得
    c = Competition.find(params[:competition_id])
    party = get_joined_party(@user, c.parties)

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

  # 参加中のコンペにおいて、自分が所属するParty情報を取得する
  def get_players_in_joined_party
    # CompetitionとUserからUserが所属するPartyを取得
    c = Competition.find(params[:competition_id])
    party = get_joined_party(@user, c.parties)

    retval = party.players

    if params[:without_myself]
      retval.delete_if do |x|
        x.user_id == @user.id
      end
    end

    respond_to do |format|
      format.json { render json: retval }
    end
  rescue ActiveRecord::RecordNotFound => e 
    # TODO 
    render json: nil
  end

private 
  # 複数のパーティーからuserが参加しているパーティーを探す
  def get_joined_party(user, parties)
    parties.each do |p|
      p.players.each do |p2|
        if p2.user == user
          return p
        end
      end
    end

    return nil
  end
end
