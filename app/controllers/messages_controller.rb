class MessagesController < ApplicationController

  before_filter :login_required


  def index
    @messages = Message.find(:all) do
      paginate :page => params[:page], :per_page => params[:per_page]
      if params[:from_id]
        id > params[:from_id]
      end
      order_by created_at.desc
    end
    respond_to do |wants|
      wants.json { render :json => @messages }
      wants.xml { render :xml => @messages }
    end
  end

  def create
    @message = current_user.messages.build(params[:message] && params[:message].merge(:kind => 'message'))
    respond_to do |wants|
      if @message.save
        wants.json { render :json => @message.to_json(:only => [:created_at, :id]) }
        wants.xml { render :xml => @message.to_xml(:only => [:created_at, :id]) }
      else
        wants.json { render :json => @message.errors.full_messages }
        wants.xml { render :xml => @message.errors.full_messages }
      end
    end
  end

end
