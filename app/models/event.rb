class Event < ActiveRecord::Base
  attr_accessible :deskripsi, :deskripsi_pendek, :kategori_id, :lokasi, :nama, :waktu_id
end
