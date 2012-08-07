class AddUploaderToEvent < ActiveRecord::Migration
  def change
    add_column :events, :uploader_id, :integer
  end
end
