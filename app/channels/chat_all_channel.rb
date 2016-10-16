# Be sure to restart your server when you modify this file. Action Cable runs in a loop that does not support auto reloading.
class ChatAllChannel < ApplicationCable::Channel
  def subscribed
    stream_from "ChatAllChannel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed

  end

  def send_message(data)
    ChatMessage.create(
      nickname: data['nickname'],
      text: data['text']
    )
  end

  class << self
    def push_message(message)
      ActionCable.server.broadcast(
        "ChatAllChannel",
        text: message.text,
        html: ApplicationController.new.render_to_string(
          partial: 'chats/message',
          locals: { message: message }
        )
      )
    end
  end

end
