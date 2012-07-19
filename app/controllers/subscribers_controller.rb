class SubscribersController < ApplicationController




  # GET /subscribers/new
  # GET /subscribers/new.json
  def new
    @subscriber = Subscriber.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @subscriber }
    end
  end



  # POST /subscribers
  # POST /subscribers.json
  def create
    @subscriber = Subscriber.new(params[:subscriber])

    respond_to do |format|
      if @subscriber.save
        format.html do
         flash[:success]= 'Email anda berhasil didaftarkan.' 
         flash.keep(:success) 
         redirect_to :action => "new"
        end
      else
        format.html { render action: "new" }
      end
    end
  end

end
