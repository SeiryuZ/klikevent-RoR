class Event < ActiveRecord::Base
  attr_accessible :deskripsi, :deskripsi_pendek, :kategori_id, :lokasi, :nama, :waktu_id

  has_many :categories, :through => :event_categories
  has_many :event_categories

  has_many :event_times, :through => :event_event_times
  has_many :event_event_times

  has_attached_file :cover_image,
    :storage => :s3,
    :bucket => ENV['S3_BUCKET_NAME'],
    :s3_credentials => {
      :access_key_id => ENV['AWS_ACCESS_KEY_ID'],
      :secret_access_key => ENV['AWS_SECRET_ACCESS_KEY']
    }
end
