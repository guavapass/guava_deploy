App.door_event = App.cable.subscriptions.create "DoorEventChannel",
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    $('#current-state').html(data.action)
    # Called when there's incoming data on the websocket for this channel
