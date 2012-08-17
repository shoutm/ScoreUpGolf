$ ->
  cstatus = SugCompetitionStatus.load()
  partyinfo = SugParty.load()

  initialize_page(cstatus, partyinfo)

  setInterval ->
    cstatus = SugCompetitionStatus.load()
    partyinfo = SugParty.load()

    # 定期的に自分のパーティメンバーのスコア情報をサーバから取得する
    collect_others_scores(cstatus, partyinfo)
    cstatus.save()

    # 定期的にスコアを描画する
    render_score(cstatus)
  , 10000



# 画面の初期描画
initialize_page = (cstatus, partyinfo) ->
  $(".header .col_hole_no").text("#")
  $(".header .col_par").text("par")
  $(".header .col_1").text(partyinfo.self.name)
  others = partyinfo.others.to_sorted_json()
  i = 2
  for key, values of others
    $(".header .col_#{i}").text(values.name)
    i++

  # スコアの初期描画
  i = 1
  for hole in cstatus.get_holes()
    $(".row_#{i} .col_hole_no").text(hole.hole_no)
    $(".row_#{i} .col_par").text(hole.par)
    i++

  render_score(cstatus)



render_score = (cstatus) ->
  i = 1
  for hole in cstatus.get_holes()
    # 自分のスコアを表示
    if hole && hole.self_score && hole.self_score.shot_num 
      $(".row_#{i} .col_1").text(hole.self_score.shot_num)

    # パーティーメンバーのスコアを表示
    j = 2
    for player_id, score of hole.get_sorted_other_scores()
      if score && score.shot_num
        $(".row_#{i} .col_#{j}").text(score.shot_num)
      j++
    i++
  
  # 合計の再計算
  p1 = p2 = p3 = p4 = 0
  for i in [1..18]
    p1 += parseInt($(".row_#{i} .col_1").text()) if $(".row_#{i} .col_1").text() != ""
    p2 += parseInt($(".row_#{i} .col_2").text()) if $(".row_#{i} .col_2").text() != ""
    p3 += parseInt($(".row_#{i} .col_3").text()) if $(".row_#{i} .col_3").text() != ""
    p4 += parseInt($(".row_#{i} .col_4").text()) if $(".row_#{i} .col_4").text() != ""
  $(".sum .col_1").text(p1)
  $(".sum .col_2").text(p2)
  $(".sum .col_3").text(p3)
  $(".sum .col_4").text(p4)
