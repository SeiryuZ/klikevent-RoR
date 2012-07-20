class CreateEventTimes < ActiveRecord::Migration
  def change
    create_table :event_times do |t|
      t.datetime :start
      t.datetime :end

      t.timestamps
    end
  end
end
