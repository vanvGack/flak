class SessionsController < ApplicationController

  def create
    logout_keeping_session!
    user = User.authenticate(params[:session])
    if user
      user.login!
      self.current_user = user
      head :ok
    else
      head :unauthorized
    end
  end

  def destroy
    current_user.logout!
    logout_killing_session!
    head :ok
  end

end
