###
# CurrentUser object, returning info on current logged in User
###

App.CurrentUser = ->
  id:
    $('meta[name=current_user]').attr('id')

  name:
    $('meta[name=current_user]').attr('username')

  badge:
    $('meta[name=current_user]').attr('badge')

  email:
    $('meta[name=current_user]').attr('email')

  isOnline: (id) ->
    false

  setAway: ->
    $('#user-status-' + @id).removeClass 'online'
    $('#user-status-' + @id).toggleClass 'away'

  setOnline: ->
    $('#user-status-' + @id).removeClass 'away'
    $('#user-status-' + @id).toggleClass 'online'
