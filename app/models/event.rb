class Event < ActiveRecord::Base
  attr_accessible :deskripsi, :deskripsi_pendek, :lokasi, :nama, :cover_image, :hot, :published, :further_info, :order

  has_many :categories, :through => :event_categories
  has_many :event_categories

  has_many :event_times, :through => :event_event_times
  has_many :event_event_times

  has_many :users, :through => :joins
  has_many :joins


  has_attached_file :cover_image,
    :styles => {
      :small  => "250x250>",
      :medium => "450x450>" },
    :storage => :s3, 
    :s3_credentials => "#{Rails.root}/config/s3.yml",
    :path => "events/:id/cover.:extension",
    :url  => ":s3_sg_url"

  def to_param
    # Use another column instead of the primary key 'id':
    "#{self.id}-#{self.nama.parameterize}"
  end


end
