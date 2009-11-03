class ApplicationController < ActionController::Base

  include AuthenticatedSystem

  helper :all
  filter_parameter_logging :password, :password_confirmation

end
