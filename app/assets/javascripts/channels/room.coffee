App.room = App.cable.subscriptions.create "RoomChannel",
  collection: -> $("[data-channel='room']")
  connected: ->
    @followCurrentRoom()
    @installPageChangeCallback()
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    @collection().append(data.message)
    App.scrollToBottom()

  speak: (message) ->
    @perform 'speak', message: message

  userIsCurrentUser: (message) ->
    App.CurrentUser().isCurrent($(message).attr('data-user-id'))

  followCurrentRoom: ->
    if roomId = @collection().data('room-id')
      @perform 'follow', room_id: roomId
    else
      @perform 'unfollow'

  installPageChangeCallback: ->
    unless @installedPageChangeCallback
      @installedPageChangeCallback = true
      $(document).on 'page:change', -> App.room.followCurrentRoom()

$(document).on 'keypress', '[data-behavior="room_speaker"]', (event) ->
  if event.keyCode is 13
    if event.target.value.length > 0
      $(event.target).closest('form').submit()
    event.target.value = ''
    event.preventDefault()
