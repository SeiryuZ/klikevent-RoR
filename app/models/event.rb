class Event < ActiveRecord::Base
  attr_accessible :deskripsi, :deskripsi_pendek, :kategori_id, :lokasi, :nama, :waktu_id

  has_many :categories, :through => :event_categories
  has_many :event_categories

  has_many :event_times, :through => :event_event_times
  has_many :event_event_times
end
