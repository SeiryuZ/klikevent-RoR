class EventsController < ApplicationController
  
  def hot
    @events = []
    @events << Event.find_by_hot(true, :limit => 5)
    
    total = @events.count

    if total < 5 
      remaining = 5 - total
      @events << Event.find_by_hot(false, :limit => 5)
    end
  end


  # GET /events
  # GET /events.json
  def index
    @events = Event.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @events }
    end
  end

  # GET /events/1
  # GET /events/1.json
  def show
    @event = Event.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @event }
    end
  end

  # GET /events/new
  # GET /events/new.json
  def new
    @event = Event.new
    

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @event }
    end
  end

  # GET /events/1/edit
  def edit
    @event = Event.find(params[:id])
  end

  # POST /events
  # POST /events.json
  def create
   

    @event = Event.new(params[:event])
    @event.hot = false
    @event.published = false
    @category = params[:category][:category_id]
    @start = params[:start_date]
    @end =  params[:end_date]
    e = []
    c = []
    @start.keys.each do |key|
      t1 = DateTime.new(@start[key][:year].to_i, @start[key][:month].to_i, @start[key][:day].to_i, @start[key][:hour].to_i, @start[key][:minute].to_i)
      t2 = DateTime.new(@end[key][:year].to_i, @end[key][:month].to_i, @end[key][:day].to_i, @end[key][:hour].to_i, @end[key][:min].to_i)
      e << EventTime.new(:start=>t1, :end =>t2)
    end

    @category.keys.each do |key|
      if @category[key] != ""
        c << Category.find(@category[key])
      end
    end

    @event.categories = c
    @event.event_times = e
    print "#{Rails.root}/config/s3.yml"
    respond_to do |format|
      if @event.save
        format.html { redirect_to @event, notice: 'Event was successfully created.' }
        format.json { render json: @event, status: :created, location: @event }
      else
        format.html { render action: "new" }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /events/1
  # PUT /events/1.json
  def update
    @event = Event.find(params[:id])

    respond_to do |format|
      if @event.update_attributes(params[:event])
        format.html { redirect_to @event, notice: 'Event was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    @event = Event.find(params[:id])
    @event.destroy

    respond_to do |format|
      format.html { redirect_to events_url }
      format.json { head :no_content }
    end
  end
end
