class CreateEventEventTimes < ActiveRecord::Migration
  def change
    create_table :event_event_times do |t|
      t.integer :event_id
      t.integer :event_time_id

      t.timestamps
    end
  end
end
