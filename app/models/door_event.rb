class DoorEvent < ApplicationRecord
  CLOSED = 'closed'
  OPENED = 'opened'

  enum action: [CLOSED, OPENED]

  after_commit do
    ActionCable.server.broadcast(
      "DoorEventChannel",
      state: current_state,
      color: current_color,
      alert_state: current_alert,
    )
  end

  def current_alert
    opened? ? 'success' : 'danger'
  end

  def current_state
    opened? ? 'open' : 'closed'
  end

  def current_color
    opened? ? 'green' : 'red'
  end
end
