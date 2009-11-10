require 'test_helper'

class CurrentUsersControllerTest < ActionController::TestCase

  context CurrentUsersController do
    setup do
      @user = Factory(:user)
      login_as(@user)
    end

    context "#show" do
      should "return the current user's information" do
        get :show
        assert_response :success
        assert_equal @response.body, @user.to_json(User.default_serialization_options)
      end
    end

    context "#update" do
      should "return the user's updated information on success" do
        put :update, :user => { :first_name => "Bozo" }
        assert_response :success
        assert_equal "Bozo", JSON.parse(@response.body)["user"]["first_name"]
      end

      should "return errors on failure" do
        post :update, :user => { :first_name => "" }
        assert_response :success
        @user.first_name = ""
        @user.valid?
        assert_same_elements @response.body, @user.errors.full_messages.to_json
      end
    end

  end

end
