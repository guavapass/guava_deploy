App.door_event = App.cable.subscriptions.create "DoorEventChannel",
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    alert "disconnected"
    # Called when the subscription has been terminated by the server

  received: (data) ->
    $('title').html("[#{data.state}] Level 3 Bathroom")
    $('#current-state').html(data.state)
    $('#current-state').removeClass('alert-success alert-danger')
    $('#current-state').addClass("alert-#{data.alertState}")
    $('link[rel="shortcut icon"]').attr('href', "/#{data.color}_square.ico")
    $('#events').prepend(data.eventRowHtml)
    # Called when there's incoming data on the websocket for this channel

    notify_user(data)


notify_user = (data) ->
  box = $('#notify-me')
  if box.prop('checked') && data.state == 'open'
    alert "The bathroom is available! (unchecking the box)"
    box.prop('checked', false)
