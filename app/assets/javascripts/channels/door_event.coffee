App.door_event = App.cable.subscriptions.create "DoorEventChannel",
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    $('title').html("[#{data.state}] Level 3 Bathroom")
    $('#current-state').html(data.state)
    $('link[rel="shortcut icon"]').attr('href', "/#{data.color}_square.ico")
    # Called when there's incoming data on the websocket for this channel
