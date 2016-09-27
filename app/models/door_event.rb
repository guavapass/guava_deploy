class DoorEvent < ApplicationRecord
  CLOSED = 'closed'
  OPENED = 'opened'

  enum state: [CLOSED, OPENED]
end
