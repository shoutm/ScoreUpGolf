class GolfFieldService
  @search_url: "/service/golf_field_service/search"

  @search: (name) ->
    url = @search_url + "?"
    if name?
      url += "name=" + name
    res = $.ajax({
      type: "GET",
      url: url,
      dataType: "json",
      async: false
    })
    return JSON.parse(res.responseText)

window.GolfFieldService = window.GolfFieldService || GolfFieldService
