App.chat_all = App.cable.subscriptions.create "ChatAllChannel",
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    # Called when there's incoming data on the websocket for this channel
    $('#chat-all-messages').prepend(data.html)

$ ->
  $('.emoji-message').click( ->
    App.chat_all.perform('send_message', text: $(this).html())
  )
