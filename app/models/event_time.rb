class EventTime < ActiveRecord::Base
  attr_accessible :end, :start

  has_many :events, :through => :event_event_times
  has_many :event_event_times
end
