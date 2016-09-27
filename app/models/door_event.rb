class DoorEvent < ApplicationRecord
  CLOSED = 'closed'
  OPENED = 'opened'

  enum action: [CLOSED, OPENED]

  after_commit { ActionCable.server.broadcast "DoorEventChannel", action: self.current_state }

  def current_state
    opened? ? 'open' : 'closed'
  end
end
