# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
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
