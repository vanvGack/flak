class UsersController < ApplicationController

  def create
    logout_keeping_session!
    @user = User.new(params)
    if @user.save
      self.current_user = @user
      render :json => { :id => @user.id }
    else
      render :json => @user.errors.full_messages
    end
  end

end
