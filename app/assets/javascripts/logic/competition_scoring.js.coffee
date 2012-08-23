# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
  # ページロード時の初期化
  initialize_page()

  # submitボタンが押された際の動作
  $("#submit").click ->
    cstatus = SugCompetitionStatus.load()
    hole_no = $("#hole_no").text()
    # holesを頭からシークし、hole_noの値が一致するホールを探し、スコアを保存する
    for hole in cstatus.get_holes()
      if parseInt(hole_no) == parseInt(hole.hole_no)
        hole.set_self_score(parseInt($("#shot_num").text()), parseInt($("#pat_num").text()), false)
        cstatus.save()
        break
    page_load()

  # 定期的にサーバとデータを同期する
  setInterval ->
    cstatus = SugCompetitionStatus.load()
    partyinfo = SugParty.load()
    # 未送信のスコアをサーバに送信する
    send_uncommited_score(cstatus, partyinfo)

    # 定期的に自分のパーティメンバーのスコア情報をサーバから取得する
    collect_others_scores(cstatus, partyinfo)

    cstatus.save()
  , 10000

  return 



initialize_page = ->
  # localStorageからsug_competition_statusを取得
  cstatus = SugCompetitionStatus.load()
  partyinfo = SugParty.load()
  
  hash = convertQuerystringToHash(window.location.href)
  unless hash["competition_id"]
    # TODO competition_idを含まない場合、エラーを示す必要。
    return

  # localStorageにsug_competition_statusがロード済みでない、あるいは現在のコンペと
  # 合致しない情報であった場合は正しい情報がロード済みでないとしてDBからデータを取得
  # したのち、コンペ画面をロードする。
  if !cstatus || !cstatus.loaded || cstatus.competition_id != hash.competition_id || partyinfo
    # localStorageのsug_competition_statusを作成する
    url1 = "/service/competition_service/get_holes.json?competition_id=" + hash.competition_id    # コンペのホール情報取得用URL
    url2 = "/service/player_service/get_scores.json?competition_id=" + hash.competition_id        # 自らのスコア取得用URL
    url3 = "/service/competition_service/get_parties.json?competition_id=" + hash.competition_id  # コンペに属するpartyを全て返す(player情報は含まない)ためのURL
    holes_json = JSON.parse($.ajax({type: "GET", url: url1, dataType: "json", async: false }).responseText)
    selfScore_json = JSON.parse($.ajax({type: "GET", url: url2, dataType: "json", async: false }).responseText)
    parties_json = JSON.parse($.ajax({type: "GET", url: url3, dataType: "json", async: false }).responseText)
    self_party_json = get_self_party(parties_json)
    url4 = "/service/party_service/get_party_with_user.json?party_id=" + self_party_json.id       # 指定したparty_idのparty情報(player情報含む)取得用URL
    self_party_json2 = JSON.parse($.ajax({type: "GET", url: url4, dataType: "json", async: false }).responseText)
    cstatus = new SugCompetitionStatus(hash.competition_id)
    cstatus.set_holes(holes_json, self_party_json2, selfScore_json)

    # localStorageのsug_partyを作成する
    partyinfo = new SugParty()
    partyinfo.set_party_no(self_party_json2.party_no)
    partyinfo.set_players(self_party_json2.players)

    cstatus.loaded = true
    cstatus.save()
    partyinfo.save()
  data_loaded()



# ホール入力が完了した際など、ホールの切り替えの際の処理を実施する
page_load = ->
  # holesを頭からシークし、self_scoreが空であるホールを探し、hole_noをセットする(これが次プレイするホール)
  cstatus = SugCompetitionStatus.load()
  next_hole_found = false
  for hole in cstatus.get_holes()
    unless hole.self_score
      $("#hole_no").text(hole.hole_no)
      $("#shot_num").text(hole.par)
      next_hole_found = true
      break
  # スコアが全てセットされていた場合、全てのスコアをサーバへ送信してwaitページへ移動する
  unless next_hole_found
    window.show_loading_icon("white")
    partyinfo = SugParty.load()
    send_uncommited_score(cstatus, partyinfo)
    document.location = "/competition/wait" 
    window.hide_loading_icon()



# 初期データがロードされた際に呼び出される関数
data_loaded = ->
  $("#data_loaded").show()
  $("#data_not_loaded").hide()
  page_load()



# partyが複数格納されたArray(JSONオブジェクト)からselfフラグが立っているpartyを返す
get_self_party = (parties) ->
  for party in parties
    return party if party.self



# 引数に指定されたSugCompetitionStatusのスコアのうち未送信分をサーバに送信する
# holesを頭からシークし、sent=falseのものをサーバへ送信する
#
# == 引数
# cstatus      : SugCompetitionStatusのインスタンス
# partayinfo   : SugPartyのインスタンス
send_uncommited_score = (cstatus, partyinfo) ->
  for hole in cstatus.get_holes()
    if hole.self_score && hole.self_score.sent == false
      player_id = partyinfo.get_self_player_id()
      data = convertHashToQuerystring({player_id: player_id, golf_hole_id: hole.id, shot_num: hole.self_score.shot_num, pat_num: hole.self_score.pat_num})
      url = "/service/player_service/set_score"
      $.ajax(
        { 
          type: "POST"
          url:  url
          data: data
          async: false
          success: ->
            hole.self_score.sent = true
        })
