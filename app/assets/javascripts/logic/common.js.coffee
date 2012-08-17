# 自分のパーティに所属する他メンバーのスコアを取得し、保存する
#
# == 引数
# cstatus      : SugCompetitionStatusのインスタンス
# partayinfo   : SugPartyのインスタンス
window.collect_others_scores = (cstatus, partyinfo) ->
  url = "/service/player_service/get_scores.json"
  for player_id in Object.keys(partyinfo.get_others()) # othersのplayer_idのみ必要なため左記の実装
    data = convertHashToQuerystring({player_id: player_id})
    score = JSON.parse($.ajax( { type: "GET", url:  url, data: data, async: false }).responseText)
    cstatus.set_other_scores(player_id, score)

