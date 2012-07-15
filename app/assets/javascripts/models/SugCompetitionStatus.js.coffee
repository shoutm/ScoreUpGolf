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
    @holes = new Holes()
  set_holes: (holes, self_party, self_score) ->
    # @holesの初期化
    for h in holes
      hole = new  Hole(h.id, h.hole_no, h.par, h.yard)
      # holeのself_score属性の設定
      score = window.find_array_by_id(self_score, "golf_hole_id", h.id)
      hole.set_self_score(if score then new SelfScore(score.shot_num, score.pat_num, true) else null)
      # holeのother_scores属性の設定(空のスコア情報を作成)
      for p in self_party.players
        hole.add_other_score(p.user_id, null) unless p.self
      @holes.add_hole(hole)
  to_json: ->
    json = {}
    json["competition_id"] = @competition_id
    json["loaded"] = @loaded
    json["holes"] = @holes.to_json()
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
        hole.set_self_score(new SelfScore(hole_json.self_score.shot_num, hole_json.self_score.pat_num, hole_json.self_score.sent))
      else
        hole.set_self_score(null)
      # other_scoresの設定
      for player_id, score_json of hole_json.other_scores 
        if score_json && score_json.shot_num && score_json.pat_num
          score = new Score(score_json.shot_num, score_json.pat_num)
          hole.add_other_score(player_id, score)
        else 
          hole.add_other_score(player_id, null)
      cstatus.holes.add_hole(hole)
      cstatus.loaded = true
    return cstatus



  class Holes
    constructor: ->
      @holes = []
    add_hole: (hole) ->
      @holes.push(hole)
    to_json: ->
      json = []
      for hole in @holes
        json.push hole.to_json()
      return json



  class Hole
    constructor: (@id, @hole_no, @par, @yard) ->
      @other_scores = {}
    set_self_score: (@self_score) -> 
    add_other_score: (player_id, score) ->        # scoreはScoreクラスのオブジェクト
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
