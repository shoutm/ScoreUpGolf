# 引数に与えられたarrayのid要素に対して、keyが一致した要素を返却する
# ただし、arrayは要素に必ずid属性を持たなければならない
window.find_array_by_id = (array, id, key) ->
  for i in array
    return i if i[id] == key
  return null


# 画面全体をグレーにして、waitingシンボルを画面中央に出力する
window.start_waiting = (color) ->
  # 画面全体を覆うグレーのタグを追加
  $("body").prepend("<div id=\"gray_layer\" />")
  $("#gray_layer").css({
    position: "fixed",
    top: "0",
    left: "0",
    height: "100%",
    width: "100%",
    background: "black", 
    opacity: "0.60",
    })
  $("#gray_layer").activity({color: color})


# waitingを終了する
window.stop_waiting = ->
  $("#gray_layer").hide()
  $("#gray_layer").activity(false)

