# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

# sug_competition_statusのholes情報を初期化するための関数
# holes, players: CompetitionService#get_*で取得したjson
initialize_holes = (cstatus, holes, players) ->
  cstatus.holes = []
  for h in holes
    hole = {} 
    hole.id = h.id
    hole.hole_no = h.hole_no
    hole.par = h.par
    hole.yard = h.yard
    hole.self_score = {}
    other_scores = {}
    for p in players
      other_scores[p.user_id] = {}
    
    hole.other_scores = other_scores
    cstatus.holes.push hole   
  

$ ->
  data_loaded = ->
    $("#data_loaded").show()
    $("#data_not_loaded").hide()

  if window.location.pathname.indexOf("/competition") == 0
    cstatus = getCompetitionStatus()
    if cstatus && cstatus.loaded
      data_loaded()
    else
      storeCompetitionStatus({})

  $("#load_data_button").click ->
    cstatus = getCompetitionStatus()

    # URL上のcompetition_idを取得する
    hash = getQuerystringHash(window.location.href)
    if containsKeyInHash("competition_id", hash)
      cstatus.competition_id = hash.competition_id
      url1 = "/service/competition_service/get_holes.json?competition_id=" + hash.competition_id
      url2 = "/service/competition_service/get_players_in_joined_party.json?competition_id=" + hash.competition_id + "&without_myself=true"
      # webstorageにhole情報を読み込む
      holesStr = $.ajax({type: "GET", url: url1, dataType: "json", async: false }).responseText
      playersStr = $.ajax({type: "GET", url: url2, dataType: "json", async: false }).responseText
      holes = JSON.parse(holesStr)
      players = JSON.parse(playersStr)

      initialize_holes(cstatus, holes, players)
      cstatus.loaded = true
      storeCompetitionStatus(cstatus) 
      data_loaded()
  return 
