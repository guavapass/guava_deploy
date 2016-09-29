class CreateVisits < ActiveRecord::Migration[5.0]
  def change
    create_table :visits do |t|
      t.datetime :start_at, index: true
      t.datetime :end_at, index: true

      t.timestamps
    end

    add_column :door_events, :visit_id, :integer
    add_index :door_events, :visit_id

    build_visits
  end

  def build_visits
    Visit.skip_callback(:commit)

    DoorEvent.order(created_at: :asc).each do |event|
      if event.closed?
        if Visit.first.nil? || Visit.last.end_at
          Visit.create!(start_at: event.created_at)
        end
      else
        if !Visit.last.end_at.present?
          Visit.last.update(end_at: event.created_at)
        end
      end
    end

  end
end
