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
  end

end
