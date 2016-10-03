# Be sure to restart your server when you modify this file. Action Cable runs in a loop that does not support auto reloading.
class DoorEventChannel < ApplicationCable::Channel

  def subscribed
    stream_from 'DoorEventChannel'

    CurrentState.push_state
  end

  def unsubscribed
    stop_all_streams

    CurrentState.push_state
  end
end
