class Service::FriendServiceController < ApplicationController
  # == 概要
  # 引数に指定されたidを元にゴルフレ申請を行う
  # 申請が完了した際はレスポンスコード200を返却する
  # 該当するidを持つUserが存在しない場合、必要な引数が与えられない場合は
  # エラーとしてレスポンスコード400を返す
  #
  # == 引数
  # user_id
  #
  # == 出力例
  # なし
  def apply
    if params[:user_id] == nil
      render(status: 400, json: nil); return 
    end

    FriendRelation.transaction do 
      fr1 = FriendRelation.new(:"user_id" => @user.id, :"friend_id" => params[:user_id].to_i, state: FriendRelation::State::REQUESTING)
      fr2 = FriendRelation.new(:"user_id" => params[:user_id].to_i, :"friend_id" => @user.id, state: FriendRelation::State::BE_REQUESTED)
      fr1.save
      fr2.save
    end

    respond_to do |format|
      format.json { render json: nil } 
    end
  rescue
    render status: 400, json: nil
  end

  # == 概要
  # 引数に指定されたidからのゴルフレ申請に対する承認を行う
  # 申請が完了した際はレスポンスコード200を返却する
  # 該当するidを持つUserが存在しない場合、必要な引数が与えられない場合、
  # 承認すべき申請が存在しない場合エラーとしてレスポンスコード400を返す
  #
  # == 引数
  # user_id
  #
  # == 出力例
  # なし
  def accept
    if params[:user_id] == nil
      render(status: 400, json: nil); return 
    end

    applying = FriendRelation.find(:all, conditions: {:"user_id" => params[:user_id], :"friend_id" => @user.id, state: FriendRelation::State::REQUESTING})
    applied  = FriendRelation.find(:all, conditions: ["user_id = ? and friend_id = ? and (state = ? or state = ?)", @user.id, params[:user_id], FriendRelation::State::BE_REQUESTED, FriendRelation::State::DENIED])
    if applying.size != 1 || applied.size != 1
      render(status: 400, json: nil); return 
    end

    FriendRelation.transaction do 
      applying[0].state = FriendRelation::State::BE_FRIENDS
      applied[0].state  = FriendRelation::State::BE_FRIENDS
      applying[0].save
      applied[0].save
    end

    respond_to do |format|
      format.json { render json: nil } 
    end
  rescue
    render status: 400, json: nil
  end

  # == 概要
  # 引数に指定されたidへのゴルフレ申請をキャンセルする。
  # あるいは引数に指定されたidへのゴルフレ関係を解消する。
  # 実行が成功した際はレスポンスコード200を返却する
  # 該当するidを持つUserが存在しない場合、必要な引数が与えられない場合、
  # キャンセルすべき申請等が存在しない場合エラーとしてレスポンスコード400を返す
  #
  # == 引数
  # user_id
  #
  # == 出力例
  # なし
  def cancel
    if params[:user_id] == nil
      render(status: 400, json: nil); return 
    end

    canceling = FriendRelation.find(:all, conditions: ["user_id = ? and friend_id = ? and (state = ? or state = ?)", 
                                    @user.id, params[:user_id], FriendRelation::State::BE_FRIENDS, FriendRelation::State::REQUESTING])
    canceled  = FriendRelation.find(:all, conditions: ["user_id = ? and friend_id = ? and (state = ? or state = ? or state = ?)", 
                                    params[:user_id], @user.id, FriendRelation::State::BE_FRIENDS, FriendRelation::State::BE_REQUESTED, FriendRelation::State::DENIED])
    if canceling.size != 1 || canceled.size != 1
      render(status: 400, json: nil); return 
    end

    FriendRelation.transaction do 
      canceling[0].state = FriendRelation::State::BREAKED_OFF
      canceled[0].state  = FriendRelation::State::BREAKED_OFF
      canceling[0].save
      canceled[0].save
    end

    respond_to do |format|
      format.json { render json: nil } 
    end
  rescue
    render status: 400, json: nil
  end

  # == 概要
  # 引数に指定されたidからのゴルフレ申請を拒否する。
  # 実行が成功した際はレスポンスコード200を返却する
  # 該当するidを持つUserが存在しない場合、必要な引数が与えられない場合、
  # 拒否すべき申請等が存在しない場合エラーとしてレスポンスコード400を返す
  #
  # == 引数
  # user_id
  #
  # == 出力例
  # なし
  def deny
    if params[:user_id] == nil
      render(status: 400, json: nil); return 
    end

    denying = FriendRelation.find(:all, conditions: {:"user_id" => @user.id, :"friend_id" => params[:user_id], state: FriendRelation::State::BE_REQUESTED})
    denied  = FriendRelation.find(:all, conditions: {:"user_id" => params[:user_id], :"friend_id" => @user.id, state: FriendRelation::State::REQUESTING})
    if denying.size != 1 || denied.size != 1
      render(status: 400, json: nil); return 
    end

    denying[0].state = FriendRelation::State::DENIED
    denying[0].save

    respond_to do |format|
      format.json { render json: nil } 
    end
  rescue
    render status: 400, json: nil
  end

end
