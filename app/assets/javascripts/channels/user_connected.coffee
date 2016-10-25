App.user_connected = App.cable.subscriptions.create "UserConnectedChannel",
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    $('#peopleConnected').append(data.html)
    # Called when there's incoming data on the websocket for this channel
