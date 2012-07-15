window.storeCompetitionStatus = (obj) ->
  localStorage.sug_competition_status = JSON.stringify(obj)

window.getCompetitionStatus = ->
  if(typeof(localStorage.sug_competition_status) == "undefined")
    return null
  return JSON.parse(localStorage.sug_competition_status)

window.storeParty = (obj) ->
  localStorage.sug_party = JSON.stringify(obj)

window.getParty = ->
  if(typeof(localStorage.sug_competition_status) == "undefined")
    return null
  return JSON.parse(localStorage.sug_party)

