# 引数に与えられたhashをソートする
window.sort_hash = (hash) ->
  ary = []
  for key, value of hash 
    ary.push key
  ary.sort((a,b) -> a - b)
  hash2 = {}
  for key in ary
    hash2[key] = hash[key]
  hash2



window.convertQuerystringToHash = (url) ->
  retval = {}
  hashes = url.slice(url.indexOf('?') + 1).split('&')
  for hash in hashes
    key_value = hash.split('=')
    retval[key_value[0]] = key_value[1]
  return retval



# 以下のようなhashをクエリストリングに変換する
# { "name": "aaa", "age": 5 }
window.convertHashToQuerystring = (hash) ->
  retval = ""
  for key, value of hash
    retval += key + "=" + value + "&"
  return retval.slice(0, retval.length - 1)



# 連想配列を含んだarrayを引数に取り、その連想配列のid要素がvalueである
# 場合にその連想配列を返す
window.find_array_by_id = (array, id, key) ->
  for i in array
    return i if i[id] == key
  return null



# 画面全体をグレーにして、waitingシンボルを画面中央に出力する
window.show_loading_icon = (color) ->
  # 画面全体を覆うグレーのタグを追加
  $("body").prepend("<div id=\"loading_icon_layer\" />")
  $("#loading_icon_layer").css({
    position: "fixed",
    top: "0",
    left: "0",
    height: "100%",
    width: "100%",
    background: "black", 
    opacity: "0.60",
    })
  $("#loading_icon_layer").activity({color: color})



# waitingを終了する
window.hide_loading_icon = ->
  $("#loading_icon_layer").hide()
  $("#loading_icon_layer").activity(false)


