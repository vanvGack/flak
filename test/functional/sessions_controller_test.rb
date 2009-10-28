require 'test_helper'

class SessionsControllerTest < ActionController::TestCase

  context SessionsController do
    context "#create" do
      should "respond with unauthorized when unsuccessful" do
        post :create
        assert_response :unauthorized
      end

      should "respond with success and be logged in when successful" do
        user = Factory(:user, :password => 'asdfasdf', :password_confirmation => 'asdfasdf')
        post :create, :session => {:email => user.email, :password => 'asdfasdf'}
        assert_response :success
        assert_equal user.id, session[:user_id]
      end
    end

    context "#destroy" do
      should "respond with success and be logged out" do
        login_as(Factory(:user))
        delete :destroy
        assert_response :success
        assert_nil session[:user_id]
      end
    end
  end

end
