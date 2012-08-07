ActiveAdmin.register Event do

  index do
    column :id do |event|
      link_to event.id, admin_event_path(event)
    end
    column :nama
    column :lokasi
    column :hot
    column :published
    column :uploader
    default_actions
  end

  form :html => { :enctype => "multipart/form-data" } do |f|
    f.inputs "Details" do
      f.input :nama
      f.input :lokasi
      f.input :deskripsi_pendek, :input_html => { :class => "ckeditor" }
      f.input :deskripsi, :input_html => { :class => "ckeditor" }
      f.input :further_info, :as => :ckeditor
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


  controller do
    # This code is evaluated within the controller class
    def create
      @event = Event.create(params[:event])
      @event.uploader = current_user
      if @event.save
        flash[:notice] = "Event added!"
        redirect_to :action => :index
      else
        redirect_to :action => :new
      end
    end
    def update
      @event = Event.find(params[:id])
      @event.assign_attributes(params[:event])
      @event.uploader = current_user
      if @event.save
        redirect_to :action => :show
      else
        render action: "edit" 
      end
    end
  end
end