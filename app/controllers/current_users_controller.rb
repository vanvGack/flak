class CurrentUsersController < ApplicationController

  before_filter :login_required

  def show
    respond_to do |wants|
      wants.json { render :json => current_user.to_json(User.default_serialization_options) }
      wants.xml { render :xml => current_user.to_xml(User.default_serialization_options) }
    end
  end

  def update
    respond_to do |wants|
      if current_user.update_attributes(params[:user])
        wants.json { render :json => current_user.to_json(User.default_serialization_options) }
        wants.xml { render :xml => current_user.to_xml(User.default_serialization_options) }
      else
        wants.json { render :json => current_user.errors.full_messages }
        wants.xml { render :xml => current_user.errors }
      end
    end
  end

end
