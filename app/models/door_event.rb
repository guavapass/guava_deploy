class DoorEvent < ApplicationRecord
  CLOSED = 'closed'
  OPENED = 'opened'

  enum action: [CLOSED, OPENED]

  after_commit { push_event }

  def current_alert
    opened? ? 'success' : 'danger'
  end

  def current_state
    opened? ? 'open' : 'closed'
  end

  def current_color
    opened? ? 'green' : 'red'
  end

  def push_event
    next_event = DoorEvent.find_by(id: self.id - 1)

    return unless next_event && (self.action != next_event.action)

    ActionCable.server.broadcast(
      "DoorEventChannel",
      state: current_state,
      color: current_color,
      alertState: current_alert,
      eventRowHtml: ApplicationController.new.render_to_string(partial: 'home/event_row', locals: { event: self, next_event: next_event }).to_s,
    )
  end
end
