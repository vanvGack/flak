class ApplicationController < ActionController::Base

  include AuthenticatedSystem

  helper :all
  filter_parameter_logging :password, :password_confirmation

  before_filter :set_time_zone


protected

  def set_time_zone
    if logged_in? && current_user.time_zone
      Time.zone = current_user.time_zone
    end
  end

end
