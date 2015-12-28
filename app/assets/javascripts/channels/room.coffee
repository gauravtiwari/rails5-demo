App.room = App.cable.subscriptions.create "RoomChannel",
  collection: -> $("[data-channel='room']")
  connected: ->
    @followCurrentRoom()
    @installPageChangeCallback()
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    @appendMessage(data.message) unless @userIsCurrentUser(data.message)

  appendMessage: (message) ->
    @collection().find('.collection').append(message)

  speak: (message) ->
    @perform 'speak', message: message

  userIsCurrentUser: (message) ->
    App.CurrentUser().isCurrent($(message).attr('data-user-id'))

  followCurrentRoom: ->
    if roomId = @collection().data('room-id')
      @perform 'follow', room_id: roomId
    else
      @perform 'unfollow'

  updateOptimisticMessage: (text) ->
    @collection().find('.collection').append(
      '<li class="collection-item avatar">
        <i class="material-icons circle red">' + App.CurrentUser().badge + '</i>
        <p>' + text + '</p>
      </li>'
    )

  installPageChangeCallback: ->
    unless @installedPageChangeCallback
      @installedPageChangeCallback = true
      $(document).on 'page:change', -> App.room.followCurrentRoom()

$(document).on 'keypress', '[data-behavior="room_speaker"]', (event) ->
  if event.keyCode is 13
    App.room.updateOptimisticMessage(event.target.value)
    $(event.target).closest('form').submit()
    event.target.value = ''
    event.preventDefault()


