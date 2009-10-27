require 'test_helper'

class UsersControllerTest < ActionController::TestCase

  context UsersController do

    context "#create" do

      should "return the id of the new account on success" do
        response = post :create, :user => { :email => "asdf@asdf.com", :password => "asdfasdf", :password_confirmation => "asdfasdf" }
        assert_response :success
        assert_equal 1, JSON.parse(response.body)["user"]["id"]
      end

      should "return errors on failure" do
        response = post :create, :user => { :email => "asdf@asdf.com", :password => "asdfasdf", :password_confirmation => "asdf" }
        assert_response :success
        assert_equal "Password doesn't match confirmation", JSON.parse(response.body).first
      end

    end


    context "#index" do

      should "return the list of registered users" do
        login_as(User.create(:email => "asdf@asdf.com", :password => "asdfasdf", :password_confirmation => "asdfasdf"))
        get :index
        assert_response :success
      end

    end

  end

end
