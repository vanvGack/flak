require 'test_helper'

class UsersControllerTest < ActionController::TestCase

  context UsersController do
    context "#create" do
      should "return the id of the new user on success" do
        post :create, :key => Flak.signup_key, :user => Factory.attributes_for(:user)
        assert_response :success
        assert_equal @response.body, User.last.to_json(User.default_serialization_options)
      end

      should "return errors on failure" do
        post :create, :key => Flak.signup_key
        assert_response :success
        assert_same_elements @response.body, User.create.errors.full_messages.to_json
      end
    end

    context "#create with invalid sign up key" do
      should "return forbidden if passed the wrong sign up key" do
        post :create
        assert_response :forbidden
      end
    end

    context "#index" do
      should "return the list of registered users" do
        login_as(Factory(:user))
        get :index
        assert_response :success
      end
    end

    context "#current" do
      should "return the list of logged-in users" do
        user = Factory(:user)
        login_as(user)
        @logged_out_user = Factory(:logged_out_user)
        @active_user = Factory(:active_user)
        get :current
        assert_response :success
        assert_equal User.find_all_by_logged_in(true).to_json(User.default_serialization_options),
                     @response.body
      end
    end

    context "#prune" do
      should "logout stale users" do
        User.expects(:logout_stale!)
        get :prune
        assert_response :success
      end
    end
  end
end
