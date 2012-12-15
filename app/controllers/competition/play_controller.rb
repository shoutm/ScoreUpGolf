class Competition::PlayController < ApplicationController
  def index
  end

  def view
  end

  def wait
  end

  # == 概要
  # プレイヤーがプレイ終了時を宣言した際に実行される。
  # プレイヤーのstateを終了に遷移させ、コンペに参加する全てのプレイヤー
  # のstateが終了、辞退、棄権であった場合、コンペ自体のstateを終了に変更
  # する。
  def finish
    player = Player.find(:all, conditions: ["user_id = :user_id and state = :state", {user_id: @user.id, state: 20}])

    # エラー処理
    if player == nil 
      error_text = "The playing player doesn't exist."
    elsif player.size != 1 
      error_text = "Unknown error has occured."
    elsif player[0].shot_results.size != 18
      error_text = "You have not finished yet."
    end

    if error_text != nil
      render status: 500, text: error_text
      return
    end

    player[0].state = 30  # 終了ステータスへ変更
    player[0].save

    # 参加コンペのstateを変更するかどうか
    competition = player[0].party.competition
    done = true
    competition.parties.each do |party|
      party.players.each do |player|
        if player.state <= 20 
          done = false
        end
      end
    end

    if done
      competition.state = 40
      competition.save
    end
  end
end
