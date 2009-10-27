class MessagesController < ApplicationController

  before_filter :login_required


  def index
    @messages = Message.all
    render :json => @messages
  end

  def create
    @message = Message.new(params)
    if @message.save
      render :json => { :created_at => @message.created_at, :id => @message.id }
    else
      render :json => @message.errors.full_messages
    end
  end

end
