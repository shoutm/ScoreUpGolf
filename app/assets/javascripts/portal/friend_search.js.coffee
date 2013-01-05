$ -> 
  $("#search").click ->
    url = "/service/user_service/search.json?name=" + $("#search_input").val()
    $.mobile.loading('show')
    $.getJSON(url, callback)
        
  callback = (data, status) ->
    $("#search_result_ul").html("")
    result_html = ""
    for user in data
      result_html += '<li id="' + user.id + '">' + user.name + '</li>'
    $("#search_result_ul").append(result_html).listview('refresh')
    $.mobile.loading('hide')



