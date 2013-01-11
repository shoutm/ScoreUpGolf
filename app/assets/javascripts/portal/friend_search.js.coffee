$ -> 
  $("#search").click ->
    url = "/service/user_service/search_with_friendstate.json?name=" + $("#search_input").val()
    $.mobile.loading('show')
    $.getJSON(url, callback)
        
  callback = (data, status) ->
    $("#search_result_ul").html("")
    result_html = ""
    for user in data
      state = ""
      switch user.friend_state
        when 10 then state = '<span class="ui-li-count">申請中</span>'
        when 20 then state = '<span class="ui-li-count">友達</span>'
        when 30 then state = ''
        when 40 then state = '<span class="ui-li-count">申請拒否中</span>'
      result_html += '<li id="' + user.id + '">' + user.name + state + '</li>'
    $("#search_result_ul").append(result_html).listview('refresh')
    $.mobile.loading('hide')
