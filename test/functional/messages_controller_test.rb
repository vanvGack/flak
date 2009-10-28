require 'test_helper'

class MessagesControllerTest < ActionController::TestCase

  context MessagesController do
    context "#create" do
      should "return the id of the new message on success" do
        user = Factory(:user)
        login_as(user)
        post :create, :message => Factory.attributes_for(:message)
        assert JSON.parse(@response.body)['message']['id'], user.messages.last.id
      end

      should "return errors on failure" do
        login_as(Factory(:user))
        post :create
        assert_same_elements JSON.parse(@response.body), Message.create.errors.full_messages
      end
    end

    context "#index" do
      should "return the list of recent messages" do
        login_as(Factory(:user))
        messages = [Factory(:login_message), Factory(:stale_logout_message), Factory(:message)]
        get :index
        assert_response :success
        assert_same_elements JSON.parse(@response.body), JSON.parse(Message.all.to_json)
      end
    end
  end
end
