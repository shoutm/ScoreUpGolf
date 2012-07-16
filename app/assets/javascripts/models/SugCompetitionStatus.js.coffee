# localStorageのsug_competition_statusを表すクラス
# 定義についてはdoc/session&webstorage_format.txtを参照
class SugCompetitionStatus
  # == 引数
  # competition_id
  # holes           : CompetitionService#get_*で取得したarray(JSON)
  # self_party      : PartyService#get_party_with_userで取得したarray(JSON)
  # self_score      : PlayerService#get_scoresで取得したarray(JSON)
  constructor: (@competition_id) ->
    @loaded = false
    @holes = []

  set_holes: (holes, self_party, self_score) ->
    # @holesの初期化
    for h in holes
      hole = new  Hole(h.id, h.hole_no, h.par, h.yard)
      # holeのself_score属性の設定
      score = window.find_array_by_id(self_score, "golf_hole_id", h.id)
      if score
        hole.set_self_score(score.shot_num, score.pat_num, true)
      # holeのother_scores属性の設定(空のスコア情報を作成)
      for p in self_party.players
        hole.set_other_score(p.id, null) unless p.self
      @holes.push(hole)

  # == 概要
  # 指定されたplayer_idのスコアを設定する
  # == 引数
  # player_id
  # score     PlayerService#get_scoresで取得したarray(JSON)
  set_other_scores: (player_id, scores) ->
    for score_json in scores
      for hole in @holes
        if score_json.golf_hole_id == hole.id
          score = new Score(score_json.shot_num, score_json.pat_num)
          hole.set_other_score(player_id, score)

  # holesを表現するarrayを返す
  get_holes: ->
    return @holes

  to_json: ->
    json = {}
    json["competition_id"] = @competition_id
    json["loaded"] = @loaded
    holes_json = []
    for hole in @holes
      holes_json.push hole.to_json()
    json["holes"] = holes_json
    return json

  save: -> # localStorageにsaveする
    localStorage.sug_competition_status = JSON.stringify(this.to_json())

  # localStorageに保存されたJSONオブジェクトからSugPartyオブジェクトを作成するクラスメソッド
  # localStorageにデータが保存されていなかった場合nullを返し、SugPartyオブジェクトがloadできた場合、そのオブジェクトを返す
  @load: ->
    if(typeof(localStorage.sug_competition_status) == "undefined")
      return false
    json = JSON.parse(localStorage.sug_competition_status)
    cstatus = new SugCompetitionStatus(json.competition_id)
    for hole_json in json.holes
      hole = new Hole(hole_json.id, hole_json.hole_no, hole_json.par, hole_json.yard)
      # self_scoreの設定
      if hole_json.self_score && hole_json.self_score.shot_num && hole_json.self_score.pat_num
        hole.set_self_score(hole_json.self_score.shot_num, hole_json.self_score.pat_num, hole_json.self_score.sent)
      # other_scoresの設定
      for player_id, score_json of hole_json.other_scores 
        if score_json && score_json.shot_num && score_json.pat_num
          score = new Score(score_json.shot_num, score_json.pat_num)
          hole.set_other_score(player_id, score)
        else 
          hole.set_other_score(player_id, null)
      cstatus.holes.push(hole)
      cstatus.loaded = true
    return cstatus



  class Hole
    constructor: (@id, @hole_no, @par, @yard) ->
      @other_scores = {}
    set_self_score: (shot_num, pat_num, sent) -> 
      @self_score = new SelfScore(shot_num, pat_num, sent)
    set_other_score: (player_id, score) ->        # scoreはScoreクラスのオブジェクト
      @other_scores[player_id] = score
    to_json: ->
      json = {}
      json["id"] = @id
      json["hole_no"] = @hole_no
      json["par"] = @par
      json["yard"] = @yard
      json["self_score"] = if @self_score then @self_score.to_json() else {}
      other_scores_json = {} 
      for player_id, score of @other_scores
        other_scores_json[player_id] = if score then score.to_json() else {}
      json["other_scores"] = other_scores_json
      return json



  class Score
    constructor: (@shot_num, @pat_num) ->
    to_json: ->
      json = {}
      json["shot_num"] = @shot_num
      json["pat_num"] = @pat_num
      return json



  class SelfScore extends Score
    constructor: (shot_num, pat_num, @sent) ->
      super(shot_num, pat_num)
    to_json: ->
      json = super()
      json["sent"] = @sent
      return json



window.SugCompetitionStatus = window.SugCompetitionStatus || SugCompetitionStatus
