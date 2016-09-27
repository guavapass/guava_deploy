# Be sure to restart your server when you modify this file. Action Cable runs in a loop that does not support auto reloading.
class DoorEventChannel < ApplicationCable::Channel
  def subscribed
    stream_from 'DoorEventChannel'
  end

  def unfollow
    stop_all_streams
  end
end
