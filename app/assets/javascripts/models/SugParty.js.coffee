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

  get_self_player_id: ->
    return @self.player_id

  # othersを示すjsonを返却する
  get_others: ->
    return @others.others

  to_json: ->
    json = {}
    json["party_no"] = @party_no
    json["self"] = @self.to_json()
    json["others"] = @others.to_json()
    return json
  # localStorageにセーブする
  save: ->
    localStorage.sug_party = JSON.stringify(this.to_json())
  # localStorageに保存されたJSONオブジェクトからSugPartyオブジェクトを作成するクラスメソッド
  # localStorageにデータが保存されていなかった場合nullを返し、SugPartyオブジェクトがloadできた場合、そのオブジェクトを返す
  @load: ->
    if(typeof(localStorage.sug_party) == "undefined")
      return false
    json = JSON.parse(localStorage.sug_party)
    party = new SugParty()
    party.set_party_no(json.party_no)
    party.self = new Self(json.self.player_id, json.self.name)
    party.set_players2(json.others)
    return party



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
    to_sorted_json: ->
      return sort_hash(@others)


  class Other
    constructor: (@name) ->
    to_json: ->
      return { "name": @name } 
    

window.SugParty = window.SugParty || SugParty
