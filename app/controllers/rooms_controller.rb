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

  def join
    @user_room = current_user.user_rooms.build(:room => Room.find(params[:id]))
    respond_to do |wants|
      if @user_room.save
        wants.json { render :json => @user_room }
        wants.xml { render :xml => @user_room }
      else
        wants.json { render :json => @user_room.errors.full_messages, :status => :forbidden }
        wants.json { render :xml => @user_room.errors, :status => :forbidden }
      end
    end
  end

  def leave
    @user_room = current_user.user_rooms.find(:first, :conditions => { :room_id => params[:id] })
    @user_room.destroy
    render :nothing => true
  end

end
