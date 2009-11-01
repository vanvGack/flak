class RoomsController < ApplicationController

  before_filter :login_required


  def index
    @rooms = Room.find(:all) do
      paginate :page => params[:page], :per_page => params[:per_page]
      order_by name
    end
    respond_to do |wants|
      wants.json { render :json => @rooms }
      wants.xml { render :xml => @rooms }
    end
  end

  def create
    @room = Room.new(params[:room])
    respond_to do |wants|
      if @room.save
        wants.json { render :json => @room }
        wants.xml { render :xml => @room }
      else
        wants.json { render :json => @room.errors.full_messages }
        wants.xml { render :xml => @room.errors }
      end
    end
  end

end
