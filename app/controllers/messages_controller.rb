class MessagesController < ApplicationController

  before_filter :login_required


  def index
    @messages = Message.all do
      paginate :page => params[:page], :per_page => params[:per_page]
      order_by created_at.desc
    end
    render :json => @messages
  end

  def create
    @message = current_user.messages.build(params)
    @message.kind ||= "message"
    if @message.save
      render :json => { :created_at => @message.created_at, :id => @message.id }
    else
      render :json => @message.errors.full_messages
    end
  end

end
