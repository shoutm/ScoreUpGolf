# SugPartyを表すクラス
# 定義についてはdoc/session&webstorage_format.txtを参照
class SugParty 
  constructor: () ->
    @self = null
    @others = new Others()
  set_party_no: (@party_no) ->
  # PartyServiceControllerのget_party_with_userの出力のplayers(json)が引数として渡される
  set_players: (players) ->
    for player in players
      if player.self
        @self = new Self(player.id, player.user.name)
      else
        @others.add_player(player)
  # localStorageからの復元の際に使われるメソッド
  set_players2: (players) -> 
    for player_id, player of players
      if ! player.self
        @others.add_player2(player_id, player)
  # localStorageに保存されたJSONオブジェクトからのロード
  load_json: (json) ->
    this.set_party_no(json.party_no)
    @self = new Self(json.self.player_id, json.self.name)
    @others = new Others()
    this.set_players2(json.others)
  to_json: ->
    json = {}
    json["party_no"] = @party_no
    json["self"] = @self.to_json()
    json["others"] = @others.to_json()
    return json


  class Self
    constructor: (@player_id, @name) ->
    to_json: ->
      return { "player_id": @player_id, "name": @name} 


  class Others
    others: {}
    constructor: ->
    add_player: (player) ->
      other = new Other(player.user.name)
      @others[player.id] = other
    add_player2: (player_id, player) ->
      other = new Other(player.name) 
      @others[player_id] = other
    to_json: ->
      return @others


  class Other
    constructor: (@name) ->
    to_json: ->
      return { "name": @name } 
    

window.SugParty = window.SugParty || SugParty
