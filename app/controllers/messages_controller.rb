class MessagesController < ApplicationController

  before_filter :login_required


  def index
    @messages = Message.find(:all, :include => :user) do
      paginate :page => params[:page], :per_page => params[:per_page]
      if params[:kind]
        kind == params[:kind]
      end
      if params[:after_id]
        id > params[:after_id]
        order_by created_at
      elsif params[:before_id]
        id < params[:before_id]
        order_by created_at.desc
      else
        order_by created_at.desc
      end
    end
    respond_to do |wants|
      wants.json { render :json => @messages.to_json(:methods => [:user_first_name, :user_last_name]) }
      wants.xml { render :xml => @messages.to_xml(:methods => [:user_first_name, :user_last_name]) }
    end
  end

  def create
    @message = current_user.messages.build(params[:message] && params[:message].merge(:kind => 'message'))
    respond_to do |wants|
      if @message.save
        wants.json { render :json => @message.to_json(:methods => [:user_first_name, :user_last_name]) }
        wants.xml { render :xml => @message.to_xml(:methods => [:user_first_name, :user_last_name]) }
      else
        wants.json { render :json => @message.errors.full_messages }
        wants.xml { render :xml => @message.errors }
      end
    end
  end

end
