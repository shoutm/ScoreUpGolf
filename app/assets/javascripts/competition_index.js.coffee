# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
  # スコア操作ボタンが押された際の動作
  $("#shot_score_minus").click ->
    $("#shot_num").text(parseInt($("#shot_num").text()) - 1) if parseInt($("#shot_num").text()) > 1
  $("#shot_score_plus").click ->
    $("#shot_num").text(parseInt($("#shot_num").text()) + 1)
  $("#pat_score_minus").click ->
    $("#pat_num").text(parseInt($("#pat_num").text()) - 1) if parseInt($("#pat_num").text()) > 1
  $("#pat_score_plus").click ->
    $("#pat_num").text(parseInt($("#pat_num").text()) + 1) 
