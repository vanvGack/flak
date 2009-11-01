require 'test_helper'

class RoomsControllerTest < ActionController::TestCase

  context RoomsController do
    context "#index" do
      should "return the list of rooms" do
        login_as(Factory(:user))
        get :index
        assert_response :success
      end
    end

    context "#create" do
      should "return the id of the new room on success" do
        user = Factory(:user)
        login_as(user)
        post :create, :room => Factory.attributes_for(:room)
        assert JSON.parse(@response.body)['room']['id'], Room.first.id
      end

      should "return errors on failure" do
        login_as(Factory(:user))
        post :create
        assert_same_elements JSON.parse(@response.body), Room.create.errors.full_messages
      end
    end
  end

end
