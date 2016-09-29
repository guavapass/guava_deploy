class CurrentState
  class << self
    def bs_alert
      opened? ? 'success' : 'danger'
    end

    def color
      opened? ? 'green' : 'red'
    end

    def door_state
      opened? ? 'open' : 'closed'
    end

    def opened?
      Visit.last.end_at.present?
    end

    def push_state
      ActionCable.server.broadcast(
        "DoorEventChannel",
        state: door_state,
        color: color,
        alertState: bs_alert,
      )
    end
  end
end
