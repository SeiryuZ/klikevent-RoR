class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.text :nama
      t.text :lokasi
      t.integer :kategori_id
      t.integer :waktu_id
      t.text :deskripsi_pendek
      t.text :deskripsi

      t.timestamps
    end
  end
end
