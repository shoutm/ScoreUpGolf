class FriendRelationUtils
  # == 概要
  # 指定されたユーザが指定された関係であるかどうかを判定する
  #
  # == 引数
  # user1: 比較対象のUserオブジェクト
  # user2: 比較対象のUserオブジェクト
  # state: 期待する関係(FriendRelation::State)
  def FriendRelationUtils::friends?(user1, user2, state)
    return false unless user1.is_a?(User) && user2.is_a?(User) && state.is_a?(Integer)
    friend_ship = user1.friend_relations.find do |fr|
      fr.friend_id == user2.id && fr.state == state
    end

    return true if friend_ship
    return false
  end

end
