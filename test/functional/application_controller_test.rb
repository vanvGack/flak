require 'test_helper'

class ApplicationControllerTest < ActionController::TestCase

  context ApplicationController do
    context "#flak" do
      should "respond with success" do
        get :flak
        assert_response :success
      end
    end
  end

end
