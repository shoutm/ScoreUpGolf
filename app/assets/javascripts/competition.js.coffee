# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

# localStorageのsug_competition_statusのholes情報を初期化するための関数
# holes       : CompetitionService#get_*で取得したarray(JSON)
# self_party  : 自分が所属するpartyのarray(JSON)
# selfScore   : PlayerService#get_scoresで取得したarray(JSON)
initialize_sug_competition_status = (holes, self_party, selfScore) ->
  cstatus = {}
  cstatus.holes = []
  for h in holes
    hole = {} 
    hole.id = h.id
    hole.hole_no = h.hole_no
    hole.par = h.par
    hole.yard = h.yard
    
    # set self score
    hole.self_score = {}
    score = window.find_array_by_id(selfScore, "golf_hole_id", h.id)
    if score
      hole.self_score.shot_num = score.shot_num
      hole.self_score.pat_num = score.pat_num
      hole.self_score.sent = true
    
    # set others score
    other_scores = {}
    for p in self_party.players
      other_scores[p.user_id] = {} unless p.self
    hole.other_scores = other_scores

    cstatus.holes.push hole   
  return cstatus
  
# localStorageのsug_partyを初期化するための関数
# self_party  : 自分が所属するpartyのarray(JSON)
initialize_sug_party = (self_party) ->
  partyinfo = {}
  partyinfo.party_no = self_party.party_no
  partyinfo.self = {}
  partyinfo.others = {}
  
  for player in self_party.players
    if player.self
      partyinfo.self.player_id = player.id
      partyinfo.self.name = player.user.name
    else
      partyinfo.others[player.id] = {}
      partyinfo.others[player.id].name = player.user.name
  return partyinfo

# partyが複数格納されたArray(JSONオブジェクト)からselfフラグが立っているpartyを返す
get_self_party = (parties) ->
  for party in parties
    return party if party.self

$ ->
  # ホール入力が完了した際など、ホールの切り替えの際の処理を実施する
  page_load = ->
    # holesを頭からシークし、self_scoreが空であるホールを探し、hole_noをセットする(これが次プレイするホール)
    cstatus = getCompetitionStatus()
    for hole in cstatus.holes
      unless hole.self_score.shot_num
        $("#hole_no").text(hole.hole_no)
        $("#shot_num").text(hole.par)
        break

  # 初期データがロードされた際に呼び出される関数
  data_loaded = ->
    $("#data_loaded").show()
    $("#data_not_loaded").hide()
    page_load()

  # スコア操作ボタンが押された際の動作
  $("#shot_score_minus").click ->
    $("#shot_num").text(eval($("#shot_num").text()) - 1) if eval($("#shot_num").text()) > 1
  $("#shot_score_plus").click ->
    $("#shot_num").text(eval($("#shot_num").text()) + 1)
  $("#pat_score_minus").click ->
    $("#pat_num").text(eval($("#pat_num").text()) - 1) if eval($("#pat_num").text()) > 1
  $("#pat_score_plus").click ->
    $("#pat_num").text(eval($("#pat_num").text()) + 1) 

  
  # ページロード時の初期化
  if window.location.pathname.indexOf("/competition") == 0
    # localStorageからsug_competition_statusを取得
    cstatus = getCompetitionStatus()
    partyinfo = getParty()
    
    hash = convertQuerystringToHash(window.location.href)
    unless containsKeyInHash("competition_id", hash)
      # TODO competition_idを含まない場合、エラーを示す必要。以下は暫定対処
      alert("competition_id is not provided.")
      return

    # localStorageにsug_competition_statusがロード済みであり、かつ現在のコンペと合致した情報であった場合は
    # 正しい情報がロード済みであるとしてコンペ画面をロードする。
    if cstatus && cstatus.loaded && cstatus.competition_id == hash.competition_id && partyinfo
      data_loaded()

  # ページロード時にlocalStorageが初期化されていなければロードボタンを押して初期化する
  $("#load_data_button").click ->
    # URL上のcompetition_idを取得する
    hash = convertQuerystringToHash(window.location.href)
    if containsKeyInHash("competition_id", hash)
      window.start_waiting("white")

      # localStorageのsug_competition_statusを作成する
      url1 = "/service/competition_service/get_holes.json?competition_id=" + hash.competition_id
      url2 = "/service/player_service/get_scores.json?competition_id=" + hash.competition_id
      url3 = "/service/competition_service/get_parties.json?competition_id=" + hash.competition_id
      holes_json = JSON.parse($.ajax({type: "GET", url: url1, dataType: "json", async: false }).responseText)
      selfScore_json = JSON.parse($.ajax({type: "GET", url: url2, dataType: "json", async: false }).responseText)
      parties_json = JSON.parse($.ajax({type: "GET", url: url3, dataType: "json", async: false }).responseText)
      self_party_json = get_self_party(parties_json)
      url4 = "/service/party_service/get_party_with_user.json?party_id=" + self_party_json.id
      self_party_json2 = JSON.parse($.ajax({type: "GET", url: url4, dataType: "json", async: false }).responseText)
      cstatus = initialize_sug_competition_status(holes_json, self_party_json2, selfScore_json)
      cstatus.competition_id = hash.competition_id

      # localStorageのsug_partyを作成する
      partyinfo = initialize_sug_party(self_party_json2)

      cstatus.loaded = true
      window.stop_waiting()
      storeCompetitionStatus(cstatus) 
      storeParty(partyinfo) 
      
      data_loaded()

  # submitボタンが押された際の動作
  $("#submit").click ->
    cstatus = getCompetitionStatus()
    hole_no = $("#hole_no").text()
    # holesを頭からシークし、hole_noの値が一致するホールを探し、スコアを保存する
    for hole in cstatus.holes
      if eval(hole_no) == eval(hole.hole_no)
        hole.self_score.shot_num = eval($("#shot_num").text())
        hole.self_score.pat_num = eval($("#pat_num").text())
        hole.self_score.sent = false
        storeCompetitionStatus(cstatus) 
        break
    page_load()

  # 10秒置きに未送信データをサーバに送信する
  setInterval ->
    cstatus = getCompetitionStatus()
    partyinfo = getParty()
    # holesを頭からシークし、sent=falseのものをサーバへ送信する
    for hole in cstatus.holes
      if hole.self_score.sent != null && hole.self_score.sent == false
        player_id = partyinfo.self.player_id
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
    storeCompetitionStatus(cstatus)
  , 10000

  return 
