class UsersController < ApplicationController

  before_filter :login_required, :only => :index

  def index
    @users = User.all
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

end
