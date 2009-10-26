class MessagesController < ApplicationController

  before_filter :login_required


  def index
    @messages = Message.all
    render :json => @messages
  end

end
