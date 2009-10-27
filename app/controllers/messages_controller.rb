class MessagesController < ApplicationController

  before_filter :login_required


  def index
    @messages = Message.all do
      paginate :page => params[:page], :per_page => params[:per_page]
      order_by created_at.desc
    end
    render :json => @messages
  end

end
