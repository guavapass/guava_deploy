class DoorEvent < ApplicationRecord
  CLOSED = 'closed'
  OPENED = 'opened'

  enum action: [CLOSED, OPENED]
end
