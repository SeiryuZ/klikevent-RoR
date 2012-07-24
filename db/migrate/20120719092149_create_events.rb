class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.text :nama
      t.text :lokasi
      t.text :deskripsi_pendek
      t.text :deskripsi
      t.text :further_info
      t.boolean :hot
      t.boolean :published
      t.integer :order

      t.timestamps
    end
  end
end
