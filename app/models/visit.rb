class Visit < ApplicationRecord
  has_many :door_events

  after_commit { CurrentState.push_state }
end
