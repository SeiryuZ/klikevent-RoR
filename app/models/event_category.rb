class EventCategory < ActiveRecord::Base
  attr_accessible :category_id, :event_id

  belongs_to :event
  belongs_to :category
end
