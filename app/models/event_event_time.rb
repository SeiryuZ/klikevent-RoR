class EventEventTime < ActiveRecord::Base
  attr_accessible :event_id, :event_time_id

  belongs_to :event
  belongs_to :event_time
end
