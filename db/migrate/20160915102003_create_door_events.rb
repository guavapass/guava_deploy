class CreateDoorEvents < ActiveRecord::Migration[5.0]
  def change
    create_table :door_events do |t|
      t.integer :state, index: true, null: false

      t.timestamps
    end
  end
end
