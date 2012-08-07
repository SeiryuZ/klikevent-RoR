ActiveAdmin.register Event do
  form :html => { :enctype => "multipart/form-data" } do |f|
    f.inputs "Details" do
      f.input :nama
      f.input :lokasi
      f.input :deskripsi_pendek
      f.input :deskripsi
      f.input :further_info
      f.input :cover_image, :as => :file, :hint => f.template.image_tag(f.object.cover_image.url(:medium))
      f.input :hot
      f.input :published
    end
    f.inputs "Kategori Event" do
      f.has_many :event_categories do |c|
        c.input :category_id, :as => :select, :collection => Hash[Category.all.map{|col| [col.name,col.id]}]
      end
    end
    f.inputs "Waktu Event" do
      f.has_many :event_times do |e|
        e.input :start
        e.input :end
      end
    end

    f.buttons
  end
end