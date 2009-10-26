class UsersController < ApplicationController

  def create
    logout_keeping_session!
    @user = User.new(params[:user])
    if @user.save
      self.current_user = @user
      render :json => @user
    else
      render :json => @user.errors
    end
  end

end
