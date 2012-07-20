class Category < ActiveRecord::Base
  attr_accessible :keterangan, :name

  has_many :events, :through => :event_categories
  has_many :event_categories
end
