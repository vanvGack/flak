class MessagesController < ApplicationController

  before_filter :login_required


  def index
    @messages = Message.find(:all) do
      paginate :page => params[:page], :per_page => params[:per_page]
      order_by created_at.desc
    end
    render :json => @messages
  end

  def create
    @message = current_user.messages.build(params[:message].merge(:kind => 'message'))
    if @message.save
      render :json => @message.to_json(:only => [:created_at, :id])
    else
      render :json => @message.errors.full_messages
    end
  end

end
