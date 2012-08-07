class Event < ActiveRecord::Base
  attr_accessible :deskripsi, :deskripsi_pendek, :lokasi, :nama, :cover_image, :hot, :published, :further_info, :order,:event_times_attributes,:event_categories_attributes, :uploader

  has_many :categories, :through => :event_categories
  has_many :event_categories

  has_many :event_times, :through => :event_event_times
  has_many :event_event_times

  has_many :users, :through => :joins
  has_many :joins

  belongs_to :uploader, :class_name => 'User', :foreign_key => 'uploader_id'

  accepts_nested_attributes_for :event_categories, :event_times

  has_attached_file :cover_image,
    :styles => {
      :small  => "250x250>",
      :medium => "450x450>" },
    :storage => :s3, 
    :s3_credentials => "#{Rails.root}/config/s3.yml",
    :path => "events/:hash/:style/cover.:extension",
    :url  => ":s3_sg_url",
    :hash_secret => "klikevent_picture_super_secret_hash_do_not_hack_us_we_are_small_startup"


  validates :nama, :lokasi, :deskripsi_pendek, :deskripsi, :presence=>{:message =>"tidak boleh kososng"}

  def to_param
    # Use another column instead of the primary key 'id':
    "#{self.id}-#{self.nama.parameterize}"
  end


end
