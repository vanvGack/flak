class SessionsController < ApplicationController

  def create
    logout_keeping_session!
    user = User.authenticate(params[:email], params[:password])
    if user
      # Protects against session fixation attacks, causes request forgery
      # protection if user resubmits an earlier form using back
      # button. Uncomment if you understand the tradeoffs.
      # reset_session
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
