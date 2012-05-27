class PartyUtils
  # 複数のパーティからUserが所属するパーティーを取得する
  # userがnilだった場合はpartiesにself属性があるpartyを返す
  #
  # parties : partyクラスのArray
  # user    : userクラスのインスタンス
  def PartyUtils::get_joined_party(parties, user)
    parties.each do |p| 
      p.players.each do |p2|
        return p if p2.user == user
      end
    end

    return nil 
  end

  # パーティーから該当するUserのPlayerオブジェクトを取得する
  def PartyUtils::get_player(user, party)
    party.players.each do |p|
      return p if p.user == user
    end
  end
end
