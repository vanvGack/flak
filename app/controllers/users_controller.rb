class UsersController < ApplicationController

  before_filter :login_required, :only => [:index, :current]

  def index
    @users = User.find(:all) do
      paginate :page => params[:page], :per_page => params[:per_page]
      order_by email
    end
    respond_to do |wants|
      wants.json { render :json => @users.to_json(:only => [:id, :email, :first_name, :last_name]) }
      wants.xml { render :xml => @users.to_xml(:only => [:id, :email, :first_name, :last_name]) }
    end
  end

  def create
    logout_keeping_session!
    @user = User.new(params[:user])
    respond_to do |wants|
      if @user.save
        self.current_user = @user
        wants.json { render :json => @user.to_json(:only => :id) }
        wants.xml { render :xml => @user.to_xml(:only => :id) }
      else
        wants.json { render :json => @user.errors.full_messages }
        wants.xml { render :xml => @user.errors.full_messages }
      end
    end
  end

  def current
    @users = User.find(:all) do
      paginate :page => params[:page], :per_page => params[:per_page]
      logged_in == true
      order_by email
    end
    respond_to do |wants|
      wants.json { render :json => @users.to_json(:only => [:id, :email, :first_name, :last_name]) }
      wants.xml { render :xml => @users.to_xml(:only => [:id, :email, :first_name, :last_name]) }
    end
  end

  def prune
    User.logout_stale!
    head :ok
  end

end
