class GolfCourceService
  @get_cources_url: "/service/golf_cource_service/get_cources"

  @get_cources: (golf_field_id) ->
    url = @get_cources_url + "?"
    if golf_field_id?
      url += "golf_field_id=" + golf_field_id
    res = $.ajax({
      type: "GET",
      url: url,
      dataType: "json",
      async: false
    })
    return JSON.parse(res.responseText)

window.GolfCourceService = window.GolfCourceService || GolfCourceService
