$ ->
  apply_url  = "/service/friend_service/apply.json?user_id=" + getUrlVars()["user_id"]
  cancel_url = "/service/friend_service/cancel.json?user_id=" + getUrlVars()["user_id"]
  accept_url = "/service/friend_service/accept.json?user_id=" + getUrlVars()["user_id"]
  deny_url   = "/service/friend_service/deny.json?user_id=" + getUrlVars()["user_id"]

  $("#apply").click ->
    $.mobile.loading('show')
    send(apply_url)
  $("#cancel").click ->
    $.mobile.loading('show')
    send(cancel_url)
  $("#accept").click ->
    $.mobile.loading('show')
    send(accept_url)
  $("#deny").click ->
    $.mobile.loading('show')
    send(deny_url)

  send = (url) ->
    $.ajax({
      type: "GET"; url: url; async: false
      success: ->
        location.reload()
      error: error
    })

  error = ->
    alert "An error has occured."
    $.mobile.loading('hide')
