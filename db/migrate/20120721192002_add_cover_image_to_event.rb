class AddCoverImageToEvent < ActiveRecord::Migration
  def change
  	add_attachment :events, :cover_image
  end
end
