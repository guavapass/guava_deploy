class DoorEvent < ApplicationRecord
  CLOSED = 'closed'
  OPENED = 'opened'

  belongs_to :visit, required: false

  enum action: [CLOSED, OPENED]

  after_commit { process_event }

  private

  def process_event
    visit = nil
    if self.closed?
      if Visit.first.nil? || Visit.last.end_at
        visit = Visit.create!(start_at: self.created_at)
      end
    else
      visit = Visit.last
      if !visit.end_at.present?
        visit.update(end_at: self.created_at)
      end
    end

    self.update_columns(visit_id: visit.id) if visit
  end

end
