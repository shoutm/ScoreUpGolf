class UserService
  @search_url: "/service/user_service/search"
  @search_with_friend_state_url: "/service/user_service/search_with_friend_state"
  @search_friend_url: "/service/user_service/search_friend"

  @search_friend: (name, email) ->
    url = @search_friend_url + "?"
    if name?
      url += "name=" + name + "&"
    if email?
      url += "email=" + email + "&"
    res = $.ajax({
      type: "GET",
      url: url,
      dataType: "json",
      async: false
    })
    return JSON.parse(res.responseText)


window.UserService = window.UserService || UserService
