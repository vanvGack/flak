class SessionsController < ApplicationController

  def create
    logout_keeping_session!
    user = User.authenticate(params[:email], params[:password])
    if user
      self.current_user = user
      head :ok
    else
      head :unauthorized
    end
  end

  def destroy
    logout_killing_session!
    head :ok
  end

end
