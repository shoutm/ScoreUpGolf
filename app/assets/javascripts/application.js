// This is a manifest file that'll be compiled into including all the files listed below.
// Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
// be included in the compiled file accessible from http://example.com/assets/application.js
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
//= require jquery
//= require jquery_ujs
//= require jquery.activity-indicator-1.0.0.min.js
//= require_tree .

function getQuerystringHash(url) {
  var vars = [], hash;
  var hashes = url.slice(url.indexOf('?') + 1).split('&');
  for(var i = 0; i < hashes.length; i++) {
    hash = hashes[i].split('=');
    vars.push(hash[0]);
    vars[hash[0]] = hash[1];
  }
  return vars;
}

function containsKeyInHash(key, hash) {
  for(var i in hash) {
    if(i == key){
      return true;
    }
  }
  return false;  
}

function storeCompetitionStatus(obj) {
  localStorage.sug_competition_status = JSON.stringify(obj);
  return;
}

function getCompetitionStatus() {
  if(localStorage.sug_competition_status == null){
    return null;
  }
  return JSON.parse(localStorage.sug_competition_status);
}

