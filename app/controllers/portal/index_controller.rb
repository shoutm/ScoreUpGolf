# encoding: UTF-8

class Portal::IndexController < ApplicationController
  def index
    # 通知の確認
    @notices = get_notices
  end


  private 
  ### インナークラス

  class Notice
    attr_accessor :msg, :uri
  end



  ### プライベートメソッド

  # == 概要
  # ユーザに対する通知がある場合
  def get_notices
    notices = []
    notice = get_playing_competition_notice
    notices << notice unless notice.nil?
    return notices
  end

  # == 概要
  # プレイ中のコンペがある場合、通知を返却する
  #
  # == 返り値
  # プレイ中のコンペがある場合: Noticeインスタンス
  # プレイ中のコンペがない場合: nil
  def get_playing_competition_notice
    player = Player.find(:first, conditions: ["user_id = ? and state = ?", @user.id, Player::State::JOINED])
    return nil if player.nil?

    notice = Notice.new
    notice.msg = "プレイ中のコンペがあります"
    notice.uri = "/competition/index?competition_id=" + player.party.competition_id.to_s
    return notice
  end
end
