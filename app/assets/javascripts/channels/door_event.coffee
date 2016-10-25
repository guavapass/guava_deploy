App.door_event = App.cable.subscriptions.create "DoorEventChannel",
  connected: (data) ->
    # awesome

  disconnected: ->
    user_disconnected()
    # Called when the subscription has been terminated by the server

  rejected: ->
    user_disconnected()

  received: (data) ->
    $('title').html("[#{data.state}] We Love Ruby SG")
    $('#current-state').html(data.state)
    $('#current-state').removeClass('alert-success alert-danger')
    $('#current-state').addClass("alert-#{data.alertState}")
    $('link[rel="shortcut icon"]').attr('href', "/#{data.color}_square.ico")
    $('#num-connected').html(data.connectedCnt)

    # Called when there's incoming data on the websocket for this channel
    notify_user(data)


notify_user = (data) ->
  box = $('#notify-me')
  if box.prop('checked') && data.state == 'open'
    alert "The bathroom is available! (unchecking the box)"
    box.prop('checked', false)

user_disconnected = ->
  $('#current-state').html('disconnected - please refresh')
  $('#current-state').removeClass('alert-success alert-danger')
  $('#current-state').addClass("alert-disconnected")
