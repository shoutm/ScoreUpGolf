$ ->
  $("#player_search").bind('textchange', (event, previousText) ->
    input_text = $(this).val()
    $("#player_search_result").html("")
    $("#player_search_result").addClass("loading")
    clearTimeout(window.timeout)
    window.timeout = setTimeout( ->
      html = render_player_search_result(input_text)
      $("#player_search_result").html(html)
      $("#player_search_result").removeClass("loading")
      associate_event_with_player_search_result()
    , 1000)
  )

  $("#golf_field_search").bind('textchange', (event, previousText) ->
    input_text = $(this).val()
    $("#golf_field_search_result").html("")
    $("#golf_field_search_result").addClass("loading")
    clearTimeout(window.timeout2)
    window.timeout2 = setTimeout( ->
      html = render_golf_field_search_result(input_text)
      $("#golf_field_search_result").html(html)
      $("#golf_field_search_result").removeClass("loading")
      associate_event_with_golf_field_search_result()
    , 1000)
  )


render_player_search_result = (input_text) ->
  users = UserService.search_friend(input_text)
  html = ""
  if users?
    for user in users
      html += "<tr id=" + user["id"] + " class=\"clickable\"><td>" + user["name"] + "</td></tr>"
  else
    html = "<div style=\"color: gray; font-style: italic; text-align: center;\">No users found.</div>"

  return html

render_golf_field_search_result = (input_text) ->
  fields = GolfFieldService.search(input_text)
  html = ""
  if fields?
    for field in fields
      html += "<tr id=" + field["id"] + " class=\"clickable\"><td>" + field["name"] + "</td></tr>"
  else
    html = "<div style=\"color: gray; font-style: italic; text-align: center;\">No golf fields found.</div>"

  return html

associate_event_with_player_search_result = ->
  $("#player_search_result tr").bind("tap", ->
    id = $(this).attr("id")
    name = $(this).children("td").text()
    user_no = unused_user_no()

    unless user_no?
      alert "You have already add 4 members."
    else
      btn = '<button name="' + user_no + '" class="delete_player"
            data-role="button" data-mini="true" data-inline="true"
            data-icon="delete" data-iconpos="right" onclick="return false;">' +
            name + '</button>'
      hidden = '<input type="hidden" name="' + user_no + '" value="' + id + '" />'
      $("#players").append(btn).append(hidden)
      $("#players button").button()
      $("#player_search").val("")
      $("#player_search_result").empty()

      # associate event with delete player button
      $(".delete_player").click( ->
        user_no = $(this).attr("name")
        $(this).parent().remove()
        $("#players input[type=hidden][name=" + user_no + "]").remove()
      )
  )

unused_user_no = ->
  return "user1_id" if $("button[name=user1_id]").length == 0
  return "user2_id" if $("button[name=user2_id]").length == 0
  return "user3_id" if $("button[name=user3_id]").length == 0
  return "user4_id" if $("button[name=user4_id]").length == 0
  return null

associate_event_with_golf_field_search_result = ->
  $("#golf_field_search_result tr").bind("tap", ->
    # show selected golf field
    id = $(this).attr("id")
    name = $(this).children("td").text()
    btn = '<button name="golf_field_id" class="delete_field"
          data-role="button" data-mini="true" data-inline="true"
          data-icon="delete" data-iconpos="right" onclick="return false;">' +
          name + '</button>'
    hidden = '<input type="hidden" name="golf_field_id" value="' + id + '" />'
    $("#golf_field").append(btn).append(hidden)
    $("#golf_field button").button()
    $("#golf_field_search").val("")
    $("#golf_field_search_result").empty()

    # associate event with delete golf field button
    $(".delete_field").click( ->
      $(this).parent().remove()
      $("#golf_field input[type=hidden]").remove()
      disable_cource_section()
    )

    # enable golf cource section
    enable_cource_section(id)
  )

enable_cource_section = (golf_field_id) ->
  cources = GolfCourceService.get_cources(golf_field_id)

  options = '<option value="" selected="selected"></option>'
  for cource in cources
    options += '<option value="' + cource["id"] + '">' + cource["name"] + '</option>'
  $("#firsthalf_cource_id_select").append(options)
  $("#secondhalf_cource_id_select").append(options)
  $("#firsthalf_cource_section").show()
  $("#secondhalf_cource_section").show()

disable_cource_section = ->
  $("#firsthalf_cource_id_select").html("")
  $("#secondhalf_cource_id_select").html("")
  $("#firsthalf_cource_section").hide()
  $("#secondhalf_cource_section").hide()
