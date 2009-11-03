class MessagesController < ApplicationController

  before_filter :login_required
  before_filter :room_membership_required


  def index
    @messages = Message.find(:all, :include => :user) do
      paginate :page => params[:page], :per_page => params[:per_page]
      room_id == params[:room_id]
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
      wants.json { render :json => @messages.to_json(Message.default_serialization_options) }
      wants.xml { render :xml => @messages.to_xml(Message.default_serialization_options) }
    end
  end

  def create
    @message = current_user.messages.build(params[:message] && params[:message].merge(:kind => 'message'))
    @message.room_id = params[:room_id]
    respond_to do |wants|
      if @message.save
        wants.json { render :json => @message.to_json(Message.default_serialization_options) }
        wants.xml { render :xml => @message.to_xml(Message.default_serialization_options) }
      else
        wants.json { render :json => @message.errors.full_messages }
        wants.xml { render :xml => @message.errors }
      end
    end
  end


protected

  def room_membership_required
    if params[:room_id]
      unless current_user.room_ids.include?(params[:room_id].to_i)
        respond_to do |wants|
          wants.json { render :json => { :error => "You must be a member of this room" }, :status => :forbidden }
          wants.xml { render :xml => { :error => "You must be a member of this room" }.to_xml(:root => "errors"), :status => :forbidden }
        end
      end
    end
  end

end
