class UsersController < ApplicationController

  before_filter :login_required, :only => [:index, :current]

  def index
    @users = User.find(:all) do
      paginate :page => params[:page], :per_page => params[:per_page]
      order_by email
    end
    render :json => @users.to_json(:only => [:id, :email])
  end

  def create
    logout_keeping_session!
    @user = User.new(params[:user])
    if @user.save
      self.current_user = @user
      render :json => @user.to_json(:only => :id)
    else
      render :json => @user.errors.full_messages
    end
  end

  def current
    @users = User.find(:all) do
      paginate :page => params[:page], :per_page => params[:per_page]
      logged_in == true
      order_by email
    end
    render :json => @users.to_json(:only => [:id, :email])
  end

  def prune
    User.logout_stale!
    head :ok
  end

end
