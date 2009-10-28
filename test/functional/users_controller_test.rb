require 'test_helper'

class UsersControllerTest < ActionController::TestCase

  context UsersController do
    context "#create" do
      should "return the id of the new user on success" do
        post :create, :user => Factory.attributes_for(:user)
        assert_response :success
        assert JSON.parse(@response.body)["user"]["id"], "The id of the new user was not returned on success"
      end

      should "return errors on failure" do
        post :create
        assert_response :success
        assert_same_elements JSON.parse(@response.body), User.create.errors.full_messages
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
      should "return the list of non-stale users" do
        user = Factory(:user)
        login_as(user)
        @stale_user = Factory(:stale_user)
        @active_user = Factory(:active_user)
        get :current
        assert_response :success
        body = JSON.parse(@response.body)
        assert_equal user.id, body.first['user']['id']
        assert_equal @active_user.id, body.last['user']['id']
      end
    end
  end

end
