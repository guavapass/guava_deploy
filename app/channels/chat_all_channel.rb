# Be sure to restart your server when you modify this file. Action Cable runs in a loop that does not support auto reloading.
class ChatAllChannel < ApplicationCable::Channel
  def subscribed
    stream_from "ChatAll"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed

  end

  def push_message(message)
    ActionCable.server.broadcast(
      "ChatAll",
      text: message.text,
    )
  end
end
