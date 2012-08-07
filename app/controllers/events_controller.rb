class EventsController < ApplicationController
  
  def hot
    session[:return_to] = "/hot"
    @events = []
    temp = Event.find( :all, :limit => 5, :conditions => ["hot = ? AND published = ?", true, true])
     
    temp.each do |e| 
      @events << e
    end

    total = @events.count

    if total < 5 
      remaining = 5 - total
      temp =  Event.find(:all, :limit => 5, :conditions => ["hot = ? AND published = ?", false, true])
      temp.each  do |e|
        @events << e
      end
    end
  end

  def today 
    @date = DateTime.now
    prevDate = @date - 1.day
    nextDate = @date + 1.day
    @prevDateLink = "/date/"<<prevDate.day.to_s<<"/"<<prevDate.month.to_s<<"/"<<prevDate.year.to_s
    @nextDateLink = "/date/"<<nextDate.day.to_s<<"/"<<nextDate.month.to_s<<"/"<<nextDate.year.to_s
    eventtimes= EventTime.where('start BETWEEN ? AND ?',  @date.beginning_of_day, @date.end_of_day).all
    @events = []

    eventtimes.each do |et|
      et.events.each do |e|
        @events << e
      end
    end


    #remove duplicate
    @events = @events.uniq

  end

  def date
    @date = DateTime.new(params[:year].to_i, params[:month].to_i, params[:date].to_i)
    prevDate = @date - 1.day
    nextDate = @date + 1.day
    @prevDateLink = "/date/"<<prevDate.day.to_s<<"/"<<prevDate.month.to_s<<"/"<<prevDate.year.to_s
    @nextDateLink = "/date/"<<nextDate.day.to_s<<"/"<<nextDate.month.to_s<<"/"<<nextDate.year.to_s
    eventtimes= EventTime.where('start BETWEEN ? AND ?', @date.beginning_of_day, @date.end_of_day).all
    @events = []
    eventtimes.each do |et|
      et.events.each do |e|
        @events << e
      end
    end

    #remove duplicate
    if @events
      @events = @events.uniq
    end

    if request.xhr?
      render "date.js.coffee"
    end
  end

  def calendar
    @firstdate = Date.new(params[:year].to_i, params[:month].to_i)
    @lastdate = Date.new(params[:year].to_i, params[:month].to_i, -1)
    prevMonth = @firstdate - 1.day
    nextMonth = @lastdate + 1.day
    @prevMonthLink = "/calendar/"<<prevMonth.month.to_s<<"/"<<prevMonth.year.to_s
    @nextMonthLink = "/calendar/"<<nextMonth.month.to_s<<"/"<<nextMonth.year.to_s
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
    


    @event = Event.new
    
    @event.assign_attributes(params[:event])

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
  
    if current_user == nil
      flash[:error] = "Anda Harus Login Terlebih Dahulu"
      flash.keep(:error)
      redirect_to :controller=> "feedbacks", :action => "new"
    else
      respond_to do |format|
        if @event.save
          flash[:success] = "Terima kasih atas tips Event nya"
          flash.keep(:success)
          format.html { redirect_to :controller=> "feedbacks", :action => "new"}
          format.json { render json: @event, status: :created, location: @event }
        else
          format.html { redirect_to :controller=> "feedbacks", :action => "new" }
          format.json { render json: @event.errors, status: :unprocessable_entity }
        end
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


  def join 
    if user_signed_in?
      e = Event.find(params[:id])
      if not current_user.events.include? e
        current_user.events << e
      end
      redirect_to :action => "hot"
    else
      flash[:notice] = "Anda Harus Login Terlebih dahulu"
      flash.keep(:notice)
      redirect_to :action => "hot"
    end
  end

  def partner_new
    @event = Event.new
  end
  def partner_create
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
 
    respond_to do |format|
      if @event.save
        flash[:success] = "Terima Kasih, Event Telah di Submit. Event akan di approve oleh admin"
        flash.keep(:success)
        format.html { redirect_to :action=> "partner_new"}
      else
        format.html { render action: "partner_new" }
      end
    end
  end

end
