class DoorEvent < ApplicationRecord
  CLOSED = 'closed'
  OPENED = 'opened'

  belongs_to :visit

  enum action: [CLOSED, OPENED]

  after_commit { process_event }

  private

  def process_event
    previous_event = DoorEvent.find_by(id: self.id - 1)

    return unless preivous_event && (self.action != preivous_event.action)

    if self.closed?
      Visit.create(start_at: self.created_at)
    else
      Visit.last.update(end_at: self.created_at)
    end
  end

end
